use std::process::Command;

use crate::misc::Call;

fn config_helper() {
    Command::new("git")
        .arg("config")
        .arg("--global")
        .arg("credential.helper")
        .arg("store")
        .call();
}

pub fn config_creds() {
    Command::new("git")
        .arg("config")
        .arg("--global")
        .arg("user.email")
        .arg("\"146100@gmail.com\"")
        .call();

    Command::new("git")
        .arg("config")
        .arg("--global")
        .arg("user.name")
        .arg("\"Vladas Zakrevskis\"")
        .call();
}

pub fn config_git() {
    config_helper();
    config_creds();
}
