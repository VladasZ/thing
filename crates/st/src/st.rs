use std::path::Path;

use anyhow::{anyhow, Result};
use command::run;
use dirs::home_dir;
use git2::{Repository, StatusOptions};
use structopt::StructOpt;
use walkdir::WalkDir;

#[derive(StructOpt, Debug)]
struct Args {
    #[structopt(long)]
    all: bool,
}

fn main() -> Result<()> {
    let args = Args::from_args();

    if args.all {
        check_all()?;
    } else {
        run("git status")?;
    }

    Ok(())
}

fn check_all() -> Result<()> {
    let home = home_dir().ok_or(anyhow!("Can't get home dir"))?;

    for dir in WalkDir::new(format!("{}/dev", home.display()))
        .into_iter()
        .flatten()
    {
        if dir.path().to_string_lossy().contains("target") {
            continue;
        }

        if is_git_repo(dir.path()) && repo_has_changes(dir.path()) {
            println!("{}", dir.path().display());
        }
    }

    Ok(())
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
