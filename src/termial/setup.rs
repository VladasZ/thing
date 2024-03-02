use std::path::PathBuf;

use anyhow::Result;

pub trait TermialSetup: Sized {
    fn new() -> Result<Self>;
    fn setup_file() -> PathBuf;
    fn add_hello(&self);
    fn add_alias(&self, alias: impl ToString, command: impl ToString);
    fn add_path(&self, path: impl ToString);
}
