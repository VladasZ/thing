use std::process::Command;

pub trait Call {
    #[cfg(unix)]
    fn sudo() -> Self;
    fn call(&mut self) -> String;
    fn exec(command: &str);
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
        if !output_str.is_empty() {
            println!("{}", output_str);
        }
        if !output.status.success() {
            panic!("Failed to execute command");
        }
        output_str
    }

    fn exec(command: &str) {
        let mut commands: Vec<&str> = command.split(' ').collect();
        let mut command = Command::new(commands.remove(0));

        for part in commands {
            command.arg(part);
        }

        command.call();
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
