use std::process::Command;
use crate::command::Call;

use crate::{Result, command};

pub trait Installer {
    fn missing(&self, dep: impl AsRef<str>) -> bool {
        which::which(dep.as_ref()).is_err()
    }

    fn ok(&self, dep: impl AsRef<str>) -> bool {
        !self.missing(dep)
    }

    fn install(&self, dep: impl AsRef<str>) -> Result<()> {
        if self.ok(&dep) {
            println!("{}: OK", dep.as_ref());
            return Ok(());
        }

        match self.install_command().arg(dep.as_ref()).output() {
            Ok(output) => {
                println!("{}", std::str::from_utf8(&output.stdout).unwrap());
                if output.status.success() {
                    Ok(())
                } else {
                    Err("install error")
                }
            }
            Err(_error) => Err("install invoke error"),
        }
    }

    fn install_command(&self) -> Command;
}
