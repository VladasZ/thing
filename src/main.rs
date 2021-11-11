#![allow(dead_code)]
#![allow(unused_imports)]

mod dep;
mod installer;
#[cfg(target_os = "linux")]
mod linux_installer;
#[cfg(target_os = "macos")]
mod mac_installer;
mod misc;
#[cfg(windows)]
mod windows_installer;

use misc::config_git_credentials;

#[cfg(target_os = "linux")]
use crate::linux_installer::LinuxInstaller;
#[cfg(target_os = "macos")]
use crate::mac_installer::MacInstaller;
use crate::{installer::Installer as InstallerTrait, misc::vscode_watch_large};

pub type Result<T, E = &'static str> = std::result::Result<T, E>;

#[cfg(target_os = "macos")]
type Installer = MacInstaller;

#[cfg(target_os = "linux")]
type Installer = LinuxInstaller;

#[cfg(windows)]
type Installer = WindowsInstaller;

fn main() {
    // let installer = Installer::default();
    // dbg!(installer.install("git").unwrap());

    vscode_watch_large();
    config_git_credentials();
}
