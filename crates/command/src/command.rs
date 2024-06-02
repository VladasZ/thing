#![feature(exit_status_error)]

use std::{
    process::{Command, Stdio},
    sync::atomic::{AtomicBool, Ordering},
};

use anyhow::{bail, Result};

static DRY_RUN: AtomicBool = AtomicBool::new(false);
static LOG_COMMAND: AtomicBool = AtomicBool::new(true);

pub fn dry_run(dry: bool) {
    DRY_RUN.store(dry, Ordering::Relaxed)
}

pub fn log_command(log: bool) {
    LOG_COMMAND.store(log, Ordering::Relaxed)
}

pub fn run(command: impl Into<String>) -> Result<()> {
    let command: String = command.into();

    if LOG_COMMAND.load(Ordering::Relaxed) {
        println!("{command}");
    }

    if DRY_RUN.load(Ordering::Relaxed) {
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
