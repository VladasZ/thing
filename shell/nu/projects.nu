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

def --env p [] {
    let repo = try { projects | str join "\n" | ^fzf --height=40% --prompt="Project: " | str trim | path expand } catch { return }
    if ($repo | is-not-empty) {
        cd $repo
        clear
    }
}
