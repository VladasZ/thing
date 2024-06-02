#![feature(exit_status_error)]

use std::process::{Command, Stdio};

use anyhow::{bail, Result};
use structopt::StructOpt;

const DRY_RUN: bool = false;

#[derive(StructOpt, Debug)]
struct Args {
    commit_message: Vec<String>,
}

fn main() -> Result<()> {
    let args = Args::from_args();

    let commit_message = args.commit_message.join(" ");

    run("git pull")?;

    if !commit_message.is_empty() {
        run("git add -A")?;
        run(format!("git commit -m \"{}\"", commit_message))?;
    }

    run("git push")?;

    Ok(())
}

fn run(command: impl Into<String>) -> Result<()> {
    let command: String = command.into();

    println!("{command}");

    if DRY_RUN {
        return Ok(());
    }

    if command.is_empty() {
        bail!("Empty command");
    }

    Command::new("bash")
        .arg("-c")
        .arg(command)
        .stdout(Stdio::inherit())
        .stderr(Stdio::inherit())
        .output()?
        .status
        .exit_ok()?;

    Ok(())
}
