use std::process::Command;

use crate::command::Call;

pub fn config() {
    Command::exec("git config --global credential.helper store");
    Command::exec("git config --global user.name \"Vladas Zakrevskis\"");
    Command::exec("git config --global user.email \"146100@gmail.com\"");
}
