#![cfg(windows)]

use std::{fs::OpenOptions, io::Read, path::PathBuf};

use home::home_dir;

use crate::termial::setup::TermialSetup;

pub struct WinSetup {
    file: String,
}

impl Default for WinSetup {
    fn default() -> Self {
        let file = Self::setup_file();

        dbg!(&file);

        // New-Item $profile -Type File
        let mut file = OpenOptions::new()
            .create(true)
            .write(true)
            .open(file)
            .unwrap();

        let mut data = String::new();

        file.read_to_string(&mut data).unwrap();

        dbg!(&data);

        Self { file: data }
    }
}

impl TermialSetup for WinSetup {
    fn setup_file() -> PathBuf {
        let home = home_dir().unwrap();
        let home = home.to_string_lossy();

        let path = "/Documents/WindowsPowerShell/Microsoft.PowerShell_profile.ps1";

        format!("{home}/{path}").into()
    }

    fn add_hello(&self) {
        todo!()
    }

    fn add_alias(&self, _alias: impl ToString, _command: impl ToString) {
        todo!()
    }

    fn add_path(&self, _path: impl ToString) {
        todo!()
    }
}
