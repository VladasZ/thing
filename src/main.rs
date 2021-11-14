#![allow(dead_code)]
#![allow(unused_imports)]

mod command;
mod dep;
mod git;
mod installer;
#[cfg(target_os = "linux")]
mod linux_installer;
#[cfg(target_os = "macos")]
mod mac_installer;
mod misc;
mod nvim;
mod paths;
#[cfg(windows)]
mod windows_installer;

use std::process::Command;

use command::Call;
#[cfg(target_os = "linux")]
use misc::vscode_watch_large;

use crate::installer::Installer as InstallerTrait;
#[cfg(target_os = "linux")]
use crate::linux_installer::LinuxInstaller;
#[cfg(target_os = "macos")]
use crate::mac_installer::MacInstaller;
#[cfg(windows)]
use crate::windows_installer::WindowsInstaller;

pub type Result<T, E = &'static str> = std::result::Result<T, E>;

#[cfg(target_os = "macos")]
type Installer = MacInstaller;

#[cfg(target_os = "linux")]
type Installer = LinuxInstaller;

#[cfg(windows)]
type Installer = WindowsInstaller;

fn main() {
    // let installer = Installer::default();
    // installer.install("git").unwrap();

    paths::setup();

    // #[cfg(target_os = "linux")]
    // vscode_watch_large();
    // git::config();

    // nvim::install(&installer);

}
