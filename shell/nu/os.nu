let is_windows = $nu.os-info.name == 'windows'
let is_mac = $nu.os-info.name == 'macos'
let is_linux = $nu.os-info.name == 'linux'
let is_arch: bool = $is_linux and (open /etc/os-release | str join "\n" | str contains "ID=arch")
let is_debian: bool = $is_linux and (open /etc/os-release | str join "\n" | str contains "ID_LIKE=debian")
