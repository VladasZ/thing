def projects [] {
    [
        ~/dev/apps/ke
        ~/dev/apps/skaityk
        ~/dev/deps/hreads
        ~/dev/deps/netrun
        ~/dev/deps/neuro
        ~/dev/deps/plat
        ~/dev/deps/reflected
        ~/dev/deps/refs
        ~/dev/deps/sercli
        ~/dev/deps/test-moblie
        ~/dev/deps/vents
        ~/dev/games/labirintas
        ~/dev/games/PolyRiders-Godot
        ~/dev/job/agi/live-lens-config
        ~/dev/job/agi/live-lens-system
        ~/dev/job/agi/portal-data-pipeline-service
        ~/dev/job/interview
        ~/dev/job/siva/SIVS
        ~/dev/test-engine
        ~/dev/thing
    ]
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
