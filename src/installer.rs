use std::process::Command;

use crate::Result;

pub trait Installer {
    fn missing(&self, dep: impl AsRef<str>) -> bool {
        match self.check_command().arg(dep.as_ref()).output() {
            Ok(output) => !output.status.success(),
            Err(_error) => true,
        }
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

    fn check_command(&self) -> Command;
    fn install_command(&self) -> Command;
}
