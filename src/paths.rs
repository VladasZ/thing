use std::process::Command;

use crate::{command::Call, misc::strip_trailing_newline};

struct PathsAdder {
    #[cfg(unix)]
    hrc: String,
}

impl PathsAdder {
    #[cfg(unix)]
    pub fn add(&mut self, path: &str) {
        println!("Adding {} to path", path);

        if self.hrc.contains(path) {
            println!("{} OK", path);
            return;
        }

        println!("not in path, adding");

        self.hrc.push_str(path);
        self.hrc.push('\n');

        // dbg!(&self.hrc);
    }

    #[cfg(windows)]
    pub fn add(&mut self, path: &str) {
        //check if exists

        if self.ok(path) {
            println!("{} : OK", path);
            return;
        }

        println!("Adding {}", path);

        //elevate

        Command::new("powershell")
            .arg(format!(
                r#"[Environment]::SetEnvironmentVariable("Path", $env:Path + ";{}", "Machine")"#,
                path
            ))
            .call();
    }

    #[cfg(windows)]
    fn ok(&mut self, path: &str) -> bool {
        strip_trailing_newline(&Command::exec_param_silent(
            "powershell Test-Path -Path",
            path,
        )) == "True"
    }
}

impl Default for PathsAdder {
    #[cfg(target_os = "linux")]
    fn default() -> Self {
        use home::home_dir;

        println!("lin init");
       // let poth = "~/.bashrc";
        let home = home_dir().unwrap();
        let kok = home.join(".bashrc");
        //let canon = std::fs::canonicalize(poth);
        let hrc = std::fs::read_to_string(kok).expect("Failed to read .bashrc");
        Self { hrc }
    }

    #[cfg(target_os = "windows")]
    fn default() -> Self {
        println!("win init");
        Self {}
    }
}

#[cfg(unix)]
impl Drop for PathsAdder {
    fn drop(&mut self) {
        println!("drop paths adder");
    }
}

pub fn setup() {
    let mut adder = PathsAdder::default();
    adder.add("~/.shell/shorts");
    adder.add("~/elastio/target/debug");
}
