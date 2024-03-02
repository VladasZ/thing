use std::path::PathBuf;

pub trait TermialSetup {
    fn setup_file(&self) -> PathBuf;
    fn add_hello();
    fn add_alias(&self, alias: impl ToString, command: impl ToString);
    fn add_path(&self, path: impl ToString);
}