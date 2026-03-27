def refresh-projects [] {
    let file = ($nu.home-dir | path join ".config/nu-projects.txt")
    let all = glob $"($nu.home-dir)/dev/**/.git" --depth 8
        | where { |p| ($p | path type) == "dir" }
        | each { |p| $p | path dirname }
        | sort
    let repos = $all | where { |r|
        not ($all | any { |other| $other != $r and ($r | str starts-with $"($other)/") })
    }
    let prev = if ($file | path exists) {
        open $file | lines | where { |l| $l | is-not-empty }
    } else {
        []
    }
    let added = $repos | where { |r| not ($prev | any { |p| $p == $r }) }
    let removed = $prev | where { |p| not ($repos | any { |r| $r == $p }) }
    $repos | str join "\n" | save -f $file
    print $"Projects: ($repos | length) total, +($added | length) -($removed | length)"
}

def projects [] {
    let file = ($nu.home-dir | path join ".config/nu-projects.txt")
    if ($file | path exists) {
        open $file | lines | where { |l| $l | is-not-empty }
    } else {
        []
    }
}

def l [] {
    let repo = try { projects | str join "\n" | ^fzf --height=40% --prompt="Project: " | str trim | path expand } catch { return }
    if ($repo | is-not-empty) {
        ^lazygit -p $repo
        l
    }
}

def gh-clone [] {
    let repo = try {
        let orgs = ^gh org list | lines | where { |l| $l | is-not-empty }
        let sources = [""] ++ $orgs
        $sources | each { |owner|
            if ($owner | is-empty) {
                ^gh repo list --limit 500 --json nameWithOwner --jq '.[].nameWithOwner' | lines
            } else {
                ^gh repo list $owner --limit 500 --json nameWithOwner --jq '.[].nameWithOwner' | lines
            }
        } | flatten | where { |l| $l | is-not-empty } | str join "\n"
        | ^fzf --height=40% --prompt="GitHub: "
        | str trim
    } catch { return }
    if ($repo | is-empty) { return }
    ^git clone --recurse-submodules $"git@github.com:($repo).git"
    refresh-projects
}

def --env p [] {
    if (which fzf | is-empty) {
        let answer = (input "fzf is not installed. Install it now? [y/n] ")
        if $answer == "y" {
            if (sys host).name == "Darwin" {
                ^brew install fzf
            } else if ($"/etc/arch-release" | path exists) {
                ^sudo pacman -S --noconfirm fzf
            } else {
                ^sudo apt install -y fzf
            }
        } else {
            return
        }
    }
    let out = try {
        projects | str join "\n" | ^fzf --height=40% --prompt="Project: " --expect=ctrl-d --header="ctrl-d: delete" | lines
    } catch { return }
    let key = $out | get 0? | default ""
    let repo = $out | get 1? | default "" | str trim | path expand
    if ($repo | is-empty) { return }
    if $key == "ctrl-d" {
        let answer = (input $"Delete ($repo)? [y/n] ")
        if $answer == "y" {
            rm -rf $repo
            refresh-projects
        }
    } else {
        cd $repo
        clear
    }
}
