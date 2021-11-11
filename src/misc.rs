use std::{fs::OpenOptions, io::Write, ops::Add, process::Command};

fn strip_trailing_newline(input: &str) -> &str {
    input
        .strip_suffix("\r\n")
        .or_else(|| input.strip_suffix('\n'))
        .unwrap_or(input)
}

pub trait Call {
    #[cfg(unix)]
    fn sudo() -> Self;
    fn call(&mut self) -> String;
    fn silent_call(&mut self) -> String;
    fn command(&self) -> String;
}

impl Call for Command {
    #[cfg(unix)]
    fn sudo() -> Self {
        Command::new("sudo")
    }

    fn call(&mut self) -> String {
        println!("{}", self.command());
        let output = self.output().unwrap();
        let output_str = std::str::from_utf8(&output.stdout).unwrap().to_string();
        println!("{}", output_str);
        if !output.status.success() {
            panic!("Failed to execute command");
        }
        output_str
    }

    fn silent_call(&mut self) -> String {
        let output = self.output().unwrap();
        let output_str = std::str::from_utf8(&output.stdout).unwrap().to_string();
        if !output.status.success() {
            panic!("Failed to execute command");
        }
        output_str
    }

    fn command(&self) -> String {
        let mut command = self.get_program().to_string_lossy().into_owned();
        command.push(' ');
        let args: Vec<String> = self
            .get_args()
            .map(|a| a.to_string_lossy().into_owned())
            .collect();
        command.push_str(&args.join(" "));
        command
    }
}

fn get_watches_count() -> u64 {
    let output = Command::new("cat")
        .arg("/proc/sys/fs/inotify/max_user_watches")
        .silent_call();
    let output = strip_trailing_newline(&output);
    output.parse().unwrap()
}

pub fn config_git_credentials() {
    Command::new("git")
        .arg("config")
        .arg("--global")
        .arg("credential.helper")
        .arg("store")
        .call();
}

#[cfg(target_os = "linux")]
pub fn vscode_watch_large() {
    if get_watches_count() > 500000 {
        println!("VSCode wathes: OK");
        return;
    }

    println!("Setting VSCode watches");

    write_watches();

    Command::sudo().arg("sysctl").arg("-p").call();

    if get_watches_count() < 500000 {
        panic!("Failed to set watches count");
    }

    println!("Watches: {}", get_watches_count());
}

fn write_watches() {
    let mut file = OpenOptions::new()
        .write(true)
        .append(true)
        .open("/etc/sysctl.conf")
        .unwrap();

    if let Err(e) = writeln!(file, "fs.inotify.max_user_watches=524288") {
        eprintln!("Couldn't write to file: {}", e);
    }
}
