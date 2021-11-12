struct PathsAdder {
    #[cfg(target_os = "unix")]
    hrc: String,
}

impl PathsAdder {
    #[cfg(target_os = "unix")]
    fn add(&mut self, path: &str) {
        self.hrc.push_str(path);
        self.hrc.push('\n');
    }

    #[cfg(windows)]
    fn add(&mut self, _path: &str) {}
}

impl Default for PathsAdder {
    #[cfg(target_os = "linux")]
    fn default() -> Self {
        let hrc = std::fs::read_to_string("~/.bashrc").expect("Failed to read .bashrc");
        Self { hrc }
    }

    #[cfg(target_os = "windows")]
    fn default() -> Self {
        println!("win init");
        Self {}
    }
}

impl Drop for PathsAdder {
    fn drop(&mut self) {
        todo!()
    }
}

pub fn setup_paths() {
    let mut adder = PathsAdder::default();

    adder.add("~/.shell/")
}
