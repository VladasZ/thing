{ config, pkgs, ... }:

{
  imports =
    [
      /etc/nixos/hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Vilnius";

  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver.enable = true;

  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  services.xserver.xkb = {
    layout = "us,ru";
    variant = ",";
    options = "grp:alt_shift_toggle,grp:alt_space_toggle,ctrl:nocaps";
  };

  services.printing.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.vladas = {
    isNormalUser = true;
    description = "vladas";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
    ];
  };

  programs.firefox.enable = true;
  nixpkgs.config.allowUnfree = true;

  programs.ssh.startAgent = true;
  services.gnome.gnome-keyring.enable = true; # works in KDE too for storing SSH passphrases

  # $ nix search wget
  environment.systemPackages = with pkgs; [
    micro
    htop
    ncdu
    duf

    git
    gcc
    clang
    glibc
    binutils
    pkg-config
    cmake
    openssl
    openssl.dev # nix-shell -p pkg-config openssl
    zlib
    libiconv
    python3
    python3Packages.pip

    lazygit
    rustup
    alacritty
    vscode
    jetbrains.rust-rover

    telegram-desktop
    discord
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = false; # Steam Remote Play
    dedicatedServer.openFirewall = false; # Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Local Network Game Transfers
  };

  fonts.packages = with pkgs; [
    pkgs.nerd-fonts._0xproto
  ];

  system.stateVersion = "25.05"; # https://nixos.org/nixos/options.html

}
