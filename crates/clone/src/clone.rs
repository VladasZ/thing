use std::process::{Command, Stdio};

use anyhow::{Result, bail};
use structopt::StructOpt;

#[derive(StructOpt, Debug)]
struct Args {
    repo: String,
}

fn main() -> Result<()> {
    let args = Args::from_args();

    let link = if args.repo.starts_with("http") || args.repo.contains("@") {
        args.repo
    } else {
        format!("git@github.com:{}", args.repo)
    };

    println!("Cloning: {link}");

    let output = Command::new("git")
        .args(["clone", "--recursive", &link])
        .stdout(Stdio::inherit())
        .stderr(Stdio::inherit())
        .output()?;

    if !output.status.success() {
        bail!("Failed to clone repo");
    }

    println!("Repo cloned");

    Ok(())
}
