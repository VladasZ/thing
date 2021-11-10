#![cfg(target_os = "linux")]

use std::{process::Command, str};

use crate::installer::Installer;

pub struct LinuxInstaller {}

impl Installer for LinuxInstaller {
    fn installer_name(&self) -> &str {
        "apt"
    }

    fn check_command(&self) -> Command {
        let mut command = Command::new("command");
        command.arg("-V");
        command
    }

    fn install_command(&self) -> Command {
        let mut command = Command::new("sudo");
        command.arg("apt");
        command.arg("install");
        command
    }
}

impl Default for LinuxInstaller {
    fn default() -> Self {
        let default = Self {};
        if default.missing("apt").expect("Failed to get apt status") {
            panic!("Please install apt")
        } else {
            println!("apt: OK")
        }
        default
    }
}
