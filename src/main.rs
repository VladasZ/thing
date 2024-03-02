use std::{thread::sleep, time::Duration};

use anyhow::Result;

use crate::termial::{TermialSetup, Terminal};

mod command;
mod git;
mod termial;

fn setup_termial() -> Result<()> {
    let ter = Terminal::new()?;
    ter.add_hello();
    Ok(())
}

fn main() -> Result<()> {
    let setup = setup_termial()?;

    dbg!(&setup);

    sleep(Duration::from_secs(50));

    // let installer = Installer::default();
    // installer.install("git").unwrap();

    git::config();

    Ok(())
}
