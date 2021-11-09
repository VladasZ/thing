use crate::Result;

pub trait Dep {
    fn ok() -> Result<bool>;
    fn install() -> Result<()>;
}
