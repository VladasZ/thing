use anyhow::Result;
use command::run;
use structopt::StructOpt;

#[derive(StructOpt, Debug)]
struct Args {
    commit_message: Vec<String>,
}

fn main() -> Result<()> {
    let args = Args::from_args();

    let commit_message = args.commit_message.join(" ");

    run("git pull")?;

    if !commit_message.is_empty() {
        run("git add -A")?;
        run(format!("git commit -m \"{}\"", commit_message))?;
    }

    run("git push")?;

    Ok(())
}
