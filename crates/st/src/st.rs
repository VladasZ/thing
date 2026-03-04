use std::{
    path::{Path, PathBuf},
    process::{Command, Stdio, exit},
};

use anyhow::{Context, Result, anyhow};
use dirs::home_dir;
use git2::{Repository, StatusOptions};
use rayon::prelude::*;
use structopt::StructOpt;
use walkdir::WalkDir;

#[derive(StructOpt, Debug)]
struct Args {
    #[structopt(long)]
    pull: bool,
    #[structopt(long)]
    files: bool,
}

fn main() -> Result<()> {
    let args = Args::from_args();

    if args.pull {
        pull_all()?;
    } else {
        check_all(args.files)?;
    }

    Ok(())
}

fn pull_all() -> Result<()> {
    let repos = iter_repos()?;

    for dir in &repos {
        if repo_has_changes(dir, false) {
            return Err(anyhow!(
                "Repo: {} has changes. Commit all changes before pulling.",
                dir.display()
            ));
        }
    }

    let results: Vec<(PathBuf, Result<bool>)> = repos
        .par_iter()
        .map(|dir| {
            let res = pull_repo(dir);
            (dir.clone(), res)
        })
        .collect();

    let mut any_err = false;
    for (dir, res) in results {
        match res {
            Ok(changed) => {
                if changed {
                    println!("Pulled: {}", dir.display());
                }
            }
            Err(e) => {
                eprintln!("Failed to pull {}: {:#}", dir.display(), e);
                any_err = true;
            }
        }
    }

    if any_err {
        return Err(anyhow!("One or more repositories failed to pull"));
    }

    Ok(())
}

fn pull_repo(path: &Path) -> Result<bool> {
    let before = Command::new("git")
        .args(["rev-parse", "--verify", "HEAD"])
        .current_dir(path)
        .output()
        .ok()
        .and_then(|o| String::from_utf8(o.stdout).ok())
        .map(|s| s.trim().to_string());

    let pull_out = Command::new("git")
        .arg("pull")
        .arg("--recurse-submodules")
        .current_dir(path)
        .stdout(Stdio::piped())
        .stderr(Stdio::piped())
        .stdin(Stdio::null())
        .output()
        .with_context(|| format!("failed to run git pull in {}", path.display()))?;

    if !pull_out.status.success() {
        let stderr = String::from_utf8_lossy(&pull_out.stderr);
        return Err(anyhow!("git pull failed in {}: {}", path.display(), stderr));
    }

    let sub_out = Command::new("git")
        .arg("submodule")
        .arg("update")
        .arg("--init")
        .arg("--recursive")
        .current_dir(path)
        .stdout(Stdio::piped())
        .stderr(Stdio::piped())
        .stdin(Stdio::null())
        .output()
        .with_context(|| format!("failed to update submodules in {}", path.display()))?;

    if !sub_out.status.success() {
        let stderr = String::from_utf8_lossy(&sub_out.stderr);
        return Err(anyhow!(
            "git submodule update failed in {}: {}",
            path.display(),
            stderr
        ));
    }

    let after = Command::new("git")
        .args(["rev-parse", "--verify", "HEAD"])
        .current_dir(path)
        .output()
        .ok()
        .and_then(|o| String::from_utf8(o.stdout).ok())
        .map(|s| s.trim().to_string());

    Ok(before != after)
}

fn check_all(show_files: bool) -> Result<()> {
    let repos = iter_repos()?;

    let changed: Vec<(PathBuf, Vec<String>)> = repos
        .par_iter()
        .filter_map(|dir| repo_status_info(dir, show_files).map(|files| (dir.clone(), files)))
        .collect();

    if !changed.is_empty() {
        for (dir, files) in &changed {
            println!("{}", dir.display());
            if show_files {
                for f in files {
                    println!("{}", f);
                }
            }
        }

        println!("Uncommitted changes");
        exit(1);
    } else {
        println!("No uncommitted repositories");
    }

    Ok(())
}

fn iter_repos() -> Result<Vec<PathBuf>> {
    let home = home_dir().ok_or(anyhow!("Can't get home dir"))?;
    let repos: Vec<PathBuf> = WalkDir::new(format!("{}/dev", home.display()))
        .into_iter()
        .flatten()
        .filter(|entry| {
            let p = entry.path().to_string_lossy();
            !p.contains("target") && !p.contains("build") && is_git_repo(entry.path())
        })
        .map(|entry| entry.path().to_owned())
        .collect();

    Ok(repos)
}

fn is_git_repo(path: &Path) -> bool {
    path.join(".git").is_dir()
}

fn repo_status_info(path: &Path, show_files: bool) -> Option<Vec<String>> {
    if let Ok(repo) = Repository::discover(path) {
        let mut status_opts = StatusOptions::new();
        status_opts.include_untracked(true);

        if let Ok(statuses) = repo.statuses(Some(&mut status_opts)) {
            let mut files = Vec::new();
            let mut has_changes = false;

            for entry in statuses.iter() {
                if entry.path().is_some_and(|p| p.contains(".mmdb")) {
                    continue;
                }

                let changes = entry.status().is_wt_new()
                    || entry.status().is_wt_modified()
                    || entry.status().is_wt_deleted()
                    || entry.status().is_index_new()
                    || entry.status().is_index_modified()
                    || entry.status().is_index_deleted();

                if changes {
                    has_changes = true;
                    if show_files {
                        files.push(entry.path().unwrap_or("UNKNOWN").to_string());
                    }
                }
            }

            if has_changes {
                return Some(files);
            }
        }
    }
    None
}

fn repo_has_changes(path: &Path, show_files: bool) -> bool {
    repo_status_info(path, show_files).is_some()
}
