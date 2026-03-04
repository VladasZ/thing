# $nu.config-path

use std/util "path add"

source ~/dev/thing/shell/nu/os.nu
source ~/dev/thing/shell/nu/symlinks.nu
source ~/dev/thing/shell/nu/aliases.nu
source ~/dev/thing/shell/nu/functions.nu

path add ~/.cargo/bin
path add ~/.deno/bin/

if $is_mac {
    path add /opt/homebrew/bin
    path add /opt/homebrew/opt/llvm/bin
    path add /opt/homebrew/opt/libpq/bin
    path add /Library/Developer/CommandLineTools/usr/bin/
    path add /Users/vladas/.local/bin
}

if $is_linux {
    $env.SSH_AUTH_SOCK = $"($env.XDG_RUNTIME_DIR)/ssh-agent.socket"
}

$env.config.show_banner = false
$env.VAGRANT_DEFAULT_PROVIDER = "utm"

mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")



$env.PATH = ($env.PATH | append [
    "~/dev/thing/shell/shorts"
    "~/dev/thing/shell/_shorts"
    "~/dev/deps/qw/target/debug"
    "/Applications/Docker.app/Contents/Resources/bin"
])


npm config set fund false --location=global

# idk what is going on with this but it often fails on ios and simple macos
$env.SDKROOT = (xcrun --sdk macosx --show-sdk-path)
