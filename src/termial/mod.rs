mod setup;
mod win_setup;

pub use setup::TermialSetup;

#[cfg(windows)]
pub type Terminal = crate::termial::win_setup::WinSetup;
