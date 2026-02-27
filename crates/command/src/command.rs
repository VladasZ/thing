use std::{
    process::{Command, Stdio},
    sync::atomic::{AtomicBool, Ordering},
};

use anyhow::{Result, bail};

static DRY_RUN: AtomicBool = AtomicBool::new(false);
static LOG_COMMAND: AtomicBool = AtomicBool::new(true);

pub fn dry_run(dry: bool) {
    DRY_RUN.store(dry, Ordering::Relaxed);
}

pub fn log_command(log: bool) {
    LOG_COMMAND.store(log, Ordering::Relaxed);
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

    // Minimal shell-like splitter that respects single and double quotes and simple escapes.
    // This allows us to preserve quoted git commit messages as a single argument.
    fn split_command(cmd: &str) -> Vec<String> {
        let mut parts = Vec::new();
        let mut cur = String::new();
        let mut chars = cmd.chars().peekable();
        let mut in_single = false;
        let mut in_double = false;

        while let Some(c) = chars.next() {
            match c {
                '\\' => {
                    // take next char literally if present
                    if let Some(next) = chars.next() {
                        cur.push(next);
                    }
                }
                '\'' => {
                    if !in_double {
                        in_single = !in_single;
                        // don't include quote characters
                    } else {
                        cur.push(c);
                    }
                }
                '"' => {
                    if !in_single {
                        in_double = !in_double;
                    } else {
                        cur.push(c);
                    }
                }
                c if c.is_whitespace() => {
                    if in_single || in_double {
                        cur.push(c);
                    } else if !cur.is_empty() {
                        parts.push(cur.clone());
                        cur.clear();
                    }
                }
                other => {
                    cur.push(other);
                }
            }
        }

        if !cur.is_empty() {
            parts.push(cur);
        }

        parts
    }

    let parts = split_command(&command);

    // If the command is a git command, execute `git` directly (preserves Windows-native SSH behavior).
    if !parts.is_empty() && parts[0] == "git" {
        let mut cmd = Command::new("git");
        if parts.len() > 1 {
            cmd.args(&parts[1..]);
        }
        let status = cmd
            .stdout(Stdio::inherit())
            .stderr(Stdio::inherit())
            .stdin(Stdio::inherit())
            .output()?
            .status;

        assert!(status.success());
        return Ok(());
    }

    // Fallback: run through an OS-appropriate shell.
    // On Windows use cmd /C, on Unix use bash -c (preserves previous behavior).
    #[cfg(target_os = "windows")]
    let status = Command::new("cmd")
        .arg("/C")
        .arg(command)
        .stdout(Stdio::inherit())
        .stderr(Stdio::inherit())
        .stdin(Stdio::inherit())
        .output()?
        .status;

    #[cfg(not(target_os = "windows"))]
    let status = Command::new("bash")
        .arg("-c")
        .arg(command)
        .stdout(Stdio::inherit())
        .stderr(Stdio::inherit())
        .stdin(Stdio::inherit())
        .output()?
        .status;

    assert!(status.success());

    Ok(())
}
