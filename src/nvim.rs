use std::process::Command;

use semver::Version;
use tools::regex::find_match;

use crate::{command::Call, git};

fn version(name: impl AsRef<str>) -> Version {
    let output = Command::exec_silent(format!("{} --version", name.as_ref()));
    let version = find_match(output, r#"NVIM v(\d+)(\.\d+)(\.\d+)"#);
    Version::parse(&find_match(version, r#"(\d+)(\.\d+)(\.\d+)"#)).unwrap()
}

fn build() {
    Command::exec("pwd");
    Command::exec("mkdir -p ~/.rdeps/");
    git::clone("neovim/neovim", "~/.rdeps/neovim");
    Command::exec("make -C ~/.rdeps/neovim CMAKE_BUILD_TYPE=RelWithDebInfo");
}

pub fn install(installer: &impl crate::installer::Installer) {
    if installer.ok("nvim") {
        let version = version("nvim");

        if version.minor < 5 {
            println!("nvim is too old");
            build();
        }

        println!("nvim: OK");
        return;
    } else {
        println!("no nvim");
        build();
    }
}
