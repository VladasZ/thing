use std::{
    env::set_current_dir,
    path::{Path, PathBuf},
};

use anyhow::{Result, anyhow};
use command::run;
use dirs::home_dir;
use git2::{Repository, StatusOptions};
use structopt::StructOpt;
use walkdir::WalkDir;

#[derive(StructOpt, Debug)]
struct Args {
    #[structopt(long)]
    pull: bool,
}

fn main() -> Result<()> {
    let args = Args::from_args();

    if args.pull {
        pull_all()?;
    } else {
        check_all()?;
    }

    Ok(())
}

fn pull_all() -> Result<()> {
    for dir in iter_repos()? {
        if repo_has_changes(&dir) {
            panic!(
                "Repo: {} has changes. Commit all changes before pulling.",
                dir.display()
            );
        }
        println!("\nPulling: {}", dir.display());
        set_current_dir(&dir)?;
        run("git pull --recurse-submodules")?;
        run("git submodule update --init --recursive")?;
    }

    Ok(())
}

fn check_all() -> Result<()> {
    let mut any = false;

    for dir in iter_repos()? {
        if repo_has_changes(&dir) {
            println!("{}", dir.display());
            any = true;
        }
    }

    if !any {
        println!("No uncommitted repositories");
    }

    Ok(())
}

fn iter_repos() -> Result<impl Iterator<Item = PathBuf>> {
    let home = home_dir().ok_or(anyhow!("Can't get home dir"))?;

    let iter = WalkDir::new(format!("{}/dev", home.display()))
        .into_iter()
        .flatten()
        .filter(|a| !a.path().to_string_lossy().contains("target") && is_git_repo(a.path()))
        .map(|a| a.path().to_owned());

    Ok(iter)
}

fn is_git_repo(path: &Path) -> bool {
    path.join(".git").is_dir()
}

fn repo_has_changes(path: &Path) -> bool {
    if let Ok(repo) = Repository::discover(path) {
        let mut status_opts = StatusOptions::new();
        status_opts.include_untracked(true);

        if let Ok(statuses) = repo.statuses(Some(&mut status_opts)) {
            return statuses.iter().any(|entry| {
                if entry
                    .path()
                    .map(|path| path.contains(".mmdb"))
                    .unwrap_or_default()
                {
                    return false;
                }

                entry.status().is_wt_new()
                    || entry.status().is_wt_modified()
                    || entry.status().is_wt_deleted()
                    || entry.status().is_index_new()
                    || entry.status().is_index_modified()
                    || entry.status().is_index_deleted()
            });
        }
    }
    false
}
