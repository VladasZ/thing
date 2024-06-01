#![feature(exit_status_error)]

use std::process::{Command, Stdio};

use anyhow::{bail, Result};
use structopt::StructOpt;

#[derive(StructOpt, Debug)]
struct Args {
    commit_message: String,
}

fn main() -> Result<()> {
    let args = Args::from_args();

    run("git pull")?;
    run("git add -A")?;
    run(format!("git commit -m \"{}\"", args.commit_message))?;
    run("git push")?;

    Ok(())
}

fn run(command: impl Into<String>) -> Result<()> {
    let command: String = command.into();

    println!("{command}");

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
