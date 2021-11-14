use std::process::Command;

use home::home_dir;
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

    let path = format!("{}/.rdeps/neovim", home_dir().unwrap().to_string_lossy());

    git::clone("neovim/neovim", &path);
    Command::exec(format!("make -C {} CMAKE_BUILD_TYPE=RelWithDebInfo", path));
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
