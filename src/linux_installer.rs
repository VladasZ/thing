#![cfg(target_os = "linux")]

use std::{process::Command, str};

use crate::installer::Installer;

#[derive(Default)]
pub struct LinuxInstaller {}

impl Installer for LinuxInstaller {
    fn install_command(&self) -> Command {
        let mut command = Command::new("sudo");
        command.arg("apt");
        command.arg("install");
        command
    }
}

impl LinuxInstaller {
    fn update(&self) {}
}
