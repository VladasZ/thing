use anyhow::{bail, Result};
use std::process::{Command, Stdio};
use structopt::StructOpt;

#[derive(StructOpt, Debug)]
struct Args {
    repo: String,
}

fn main() -> Result<()> {
    let args = Args::from_args();

    let output = Command::new("git")
        .args([
            "clone",
            "--recursive",
            &format!("git@github.com:{}", args.repo),
        ])
        .stdout(Stdio::inherit())
        .stderr(Stdio::inherit())
        .output()?;

    if !output.status.success() {
        bail!("Failed to clone repo");
    }

    println!("Repo cloned");

    Ok(())
}
