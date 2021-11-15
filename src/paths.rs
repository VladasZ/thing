use std::process::Command;

use home::home_dir;

use crate::{command::Call, misc::strip_trailing_newline};

struct PathsAdder {
    #[cfg(unix)]
    hrc:      String,
    #[cfg(unix)]
    hrc_path: String,
}

impl PathsAdder {
    #[cfg(unix)]
    pub fn add(&mut self, path: &str) {
        use std::fmt::format;

        println!("Adding {} to path", path);

        if self.hrc.contains(path) {
            println!("{} OK", path);
            return;
        }

        println!("not in path, adding");

        let entry = format!("\nexport PATH=$PATH:{}\n", path);

        self.hrc.push_str(&entry);
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
}

impl Default for PathsAdder {
    #[cfg(unix)]
    fn default() -> Self {
        use home::home_dir;
        println!("lin init");
        let home = home_dir().unwrap();
        #[cfg(target_os = "linux")]
        let hrc_path = home.join(".bashrc");
        #[cfg(target_os = "macos")]
        let hrc_path = home.join(".zshrc");
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
impl Drop for PathsAdder {
    fn drop(&mut self) {
        println!("drop paths adder");
        println!("{}", self.hrc);
        std::fs::write(&self.hrc_path, &self.hrc).expect("Unable to write file");
    }
}

pub fn setup() {
    let mut adder = PathsAdder::default();
    #[cfg(windows)]
    adder.add("~/thing/.shell/shorts");
    #[cfg(unix)]
    adder.add("~/thing/_shorts");
    adder.add("~/elastio/target/debug");

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
        allow_exec(&path);
    }
}

#[cfg(unix)]
fn allow_exec(path: impl AsRef<str>) {
    Command::exec(format!("sudo chmod +x {}", path.as_ref()));
}
