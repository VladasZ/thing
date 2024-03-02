use std::path::PathBuf;

pub trait TermialSetup: Default {
    fn setup_file() -> PathBuf;
    fn add_hello(&self);
    fn add_alias(&self, alias: impl ToString, command: impl ToString);
    fn add_path(&self, path: impl ToString);
}
