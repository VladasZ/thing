use crate::termial::{TermialSetup, Terminal};

mod command;
mod git;
mod termial;

fn setup_termial() {
    let ter = Terminal::default();
    ter.add_hello();
}

fn main() {
    setup_termial();

    // let installer = Installer::default();
    // installer.install("git").unwrap();

    git::config();
}
