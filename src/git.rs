use std::process::Command;

use crate::command::Call;

/// Clone from github. Ignore all errors.
pub fn clone(link: impl AsRef<str>, to: impl AsRef<str>) {
    #![allow(unused_must_use)]
    println!("clone: {}", link.as_ref());
    let mut com = Command::new("git");

    com.arg("clone")
        .arg("--recursive")
        .arg(format!("https://github.com/{}", link.as_ref()))
        .arg(to.as_ref())
        .output();

    dbg!(com.command());
}

pub fn config() {
    Command::exec("git config pull.ff only");
    Command::exec("git config --global credential.helper store");
    Command::exec("git config --global user.name \"Vladas Zakrevskis\"");
    Command::exec("git config --global user.email \"146100@gmail.com\"");
}
