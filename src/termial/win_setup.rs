#![cfg(windows)]

use std::path::PathBuf;

use crate::termial::setup::TermialSetup;

pub struct WinSetup;

impl TermialSetup for WinSetup {
    fn setup_file(&self) -> PathBuf {
        todo!()
    }

    fn add_hello() {
        todo!()
    }

    fn add_alias(&self, _alias: impl ToString, _command: impl ToString) {
        todo!()
    }

    fn add_path(&self, _path: impl ToString) {
        todo!()
    }
}
