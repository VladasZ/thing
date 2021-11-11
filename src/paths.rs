struct PathsAdder {
    hrc: String,
}

impl PathsAdder {
    fn add(&mut self, path: &str) {
        self.hrc.push_str(path);
        self.hrc.push('\n');
    }
}

impl Default for PathsAdder {
    fn default() -> Self {
        let hrc = std::fs::read_to_string("~/.bashrc").expect("Failed to read .bashrc");
        Self { hrc }
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
