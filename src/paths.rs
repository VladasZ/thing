use std::process::Command;

use home::home_dir;

use crate::{command::Call, misc::strip_trailing_newline};

struct TerminalConfig {
    #[cfg(unix)]
    hrc:      String,
    #[cfg(unix)]
    hrc_path: String,
}

impl TerminalConfig {
    pub fn say_hello(&mut self) {
        if self.hrc.contains("Helloy") {
            return;
        }
        self.hrc.push_str("\necho Helloy\n");
    }

    pub fn add_var(&mut self, var: &str, value: &str) {
        if self.hrc.contains(var) {
            return;
        }
        self.hrc.push_str(&format!("\nexport {var}={value}\n"));
    }

    #[cfg(unix)]
    pub fn add_path(&mut self, path: &str) {
        use std::fmt::format;

        println!("Adding {path} to path");

        if self.hrc.contains(path) {
            println!("{path} OK");
            return;
        }

        println!("not in path, adding");

        let entry = format!("\nexport PATH=$PATH:{path}\n");

        self.hrc.push_str(&entry);
    }

    #[cfg(windows)]
    pub fn add_path(&mut self, path: &str) {
    }
}

impl Default for TerminalConfig {
    #[cfg(unix)]
    fn default() -> Self {
        use home::home_dir;
        println!("lin init");
        let home = home_dir().unwrap();
        #[cfg(target_os = "linux")]
        let hrc_path = home.join(".bashrc");
        #[cfg(target_os = "macos")]
        let hrc_path = home.join(".zshrc");

        dbg!(&hrc_path);

        let hrc = std::fs::read_to_string(&hrc_path).expect("Failed to read .bashrc");
        Self {
            hrc,
            hrc_path: hrc_path.to_string_lossy().into_owned(),
        }
    }

    #[cfg(target_os = "windows")]
    fn default() -> Self {
        println!("win init");
        Self {}
    }
}

#[cfg(unix)]
impl Drop for TerminalConfig {
    fn drop(&mut self) {
        println!("drop paths adder");
        std::fs::write(&self.hrc_path, &self.hrc).expect("Unable to write file");
    }
}

pub fn setup() {
    let mut terminal = TerminalConfig::default();

    terminal.say_hello();

    #[cfg(unix)]
    terminal.add_path("~/thing/_shorts");
    terminal.add_path("~/elastio/target/debug");

    terminal.add_var("AWS_PROFILE", "data-plane-isolated");
    terminal.add_var("ELASTIO_ARTIFACTS_SOURCE", "ci:master");

    let shorts = format!("{}/thing/.shell/shorts", home_dir().unwrap().display());

    dbg!(&shorts);

    let paths = std::fs::read_dir(shorts).unwrap();

    let home = home_dir().unwrap();
    let home = home.to_string_lossy();

    Command::exec(format!("mkdir -p {}/thing/_shorts", home));

    for path in paths {
        let path = path.unwrap().path();
        let name = path.file_stem().unwrap().to_string_lossy();
        let path = path.to_string_lossy();
        dbg!(&name);
        dbg!(&path);
        Command::exec(format!("ln -sf {} {}/thing/_shorts/{}", path, home, name));
        #[cfg(unix)]
        allow_exec(&path);
    }

    Command::exec(format!(
        "ln -sf {}/thing/.shell/alacritty.yml {}/.alacritty.yml",
        home, home
    ));

    Command::exec(format!(
        "ln -sf {}/thing/.shell/config {}/.ssh/config",
        home, home
    ));
}

#[cfg(unix)]
fn allow_exec(path: impl AsRef<str>) {
    Command::exec(format!("sudo chmod +x {}", path.as_ref()));
}
