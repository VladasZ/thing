use std::process::Command;
use std::str;
use crate::installer::Installer;

pub struct WindowsInstaller {}

impl Installer for WindowsInstaller {
    fn missing(&self, dep: impl AsRef<str>) -> crate::Result<bool> {
        match Command::new("powershell")
            .arg("Get-Command")
            .arg(dep.as_ref())
            .output()
        {
            Ok(output) => Ok(!output.status.success()),
            Err(_error) => Ok(true),
        }
    }

    fn install(&self, dep: impl AsRef<str>) -> crate::Result<()> {
        match Command::new("powershell")
            .arg("choco")
            .arg("install")
            .arg(dep.as_ref())
            .output()
        {
            Ok(output) => {

                println!("{}", str::from_utf8(&output.stdout).unwrap());
                if output.status.success() {
                    Ok(())
                } else {
                    Err("choco install error")
                }
            }
            Err(_error) => Err("choco install invoke error"),
        }
    }
}

impl Default for WindowsInstaller {
    fn default() -> Self {
        let default = Self {};
        if default
            .missing("choco")
            .expect("Failed to get choco status")
        {
            panic!("Please install chocolatey")
        }
        default
    }
}
