#![cfg(windows)]
use std::{process::Command, str};

use crate::installer::Installer;

pub struct WindowsInstaller {}

impl Installer for WindowsInstaller {
    fn check_command(&self) -> Command {
        let mut com = Command::new("powershell");
        com.arg("get-command");
        com
    }

    fn install_command(&self) -> Command {
        let mut com = Command::new("powershell");
        com.arg("choco");
        com.arg("install");
        com
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
