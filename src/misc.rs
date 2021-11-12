use std::{fs::OpenOptions, io::Write, ops::Add, process::Command};

use crate::command::Call;

fn strip_trailing_newline(input: &str) -> &str {
    input
        .strip_suffix("\r\n")
        .or_else(|| input.strip_suffix('\n'))
        .unwrap_or(input)
}

fn get_watches_count() -> u64 {
    let output = Command::new("cat")
        .arg("/proc/sys/fs/inotify/max_user_watches")
        .silent_call();
    let output = strip_trailing_newline(&output);
    output.parse().unwrap()
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

#[cfg(target_os = "linux")]
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
