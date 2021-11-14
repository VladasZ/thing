#![cfg(target_os = "macos")]

use std::{process::Command, str};

use crate::installer::Installer;

pub struct MacInstaller {}

impl Installer for MacInstaller {
    fn install_command(&self) -> Command {
        let mut command = Command::new("brew");
        command.arg("install");
        command
    }
}

impl Default for MacInstaller {
    fn default() -> Self {
        let default = Self {};
        if default.missing("brew") {
            panic!("Please install brew")
        } else {
            println!("brew: OK")
        }
        default
    }
}
