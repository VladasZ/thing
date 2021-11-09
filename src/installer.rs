use crate::Result;

pub trait Installer: Default {
    fn missing(&self, dep: impl AsRef<str>) -> Result<bool>;
    fn install(&self, dep: impl AsRef<str>) -> Result<()>;
}
