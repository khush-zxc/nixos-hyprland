{ config, pkgs, ... }:

{
	nixpkgs.config.allowUnfree = true;
	
  # ============================================================
  # BOOTLOADER
  # Legacy BIOS + UEFI
  # ============================================================

  boot.loader.grub = {
    enable = true;
    devices = [ "/dev/sdb" ];
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  boot.loader.efi.canTouchEfiVariables = false;


  # ============================================================
  # FILESYSTEM
  # ============================================================

 
  imports = [
    ./hardware-configuration.nix
  ];

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/2D0D-1D14";
    fsType = "vfat";
  };


  # ============================================================
  # NETWORK
  # ============================================================

  networking.networkmanager.enable = true;


  # ============================================================
  # HOSTNAME
  # ============================================================

  networking.hostName = "nixos";


  # ============================================================
  # TIME / LOCALE
  # ============================================================

  time.timeZone = "Asia/Kolkata";

  i18n.defaultLocale = "en_IN";

  console.keyMap = "us";


  # ============================================================
  # wayLAND COMPOSITOR
  # ============================================================
#HYPRLAND
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

# NIRI
  programs.niri.enable = true;
  
  # ============================================================
  # DISPLAY MANAGER
  # ============================================================

  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.gnome.enable = true;
  services.libinput.enable = true;

  # ============================================================
  # AUDIO — PIPEWIRE
  # ============================================================

  services.pipewire = {
    enable = true;

    pulse.enable = true;

    alsa.enable = true;
    alsa.support32Bit = true;

    jack.enable = true;
  };


  # ============================================================
  # BLUETOOTH
  # ============================================================

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };


  # ============================================================
  # HARDWARE
  # ============================================================

  hardware.enableRedistributableFirmware = true;


  # ============================================================
  # POLKIT
  # ============================================================

  security.polkit.enable = true;


  # ============================================================
  # XDG PORTAL
  # Required by many Wayland applications
  # ============================================================

  xdg.portal = {
    enable = true;

    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
  };


  # ============================================================
  # PROGRAMMING
  # ============================================================

  environment.systemPackages = with pkgs; [

  adwaita-icon-theme



    # ------------------------------------------------------------
    # BASIC CLI
    # ------------------------------------------------------------
  discord
  steam-run
  nspr
    git
    git-lfs

    curl
    wget

    tree
    file
    which
    findutils

    ripgrep
    fd

    jq

    less
    nano
    vim


    # ------------------------------------------------------------
    # ARCHIVES
    # ------------------------------------------------------------

    unzip
    zip

    p7zip

    gzip
    bzip2
    xz


    # ------------------------------------------------------------
    # C / C++
    # ------------------------------------------------------------

    gcc
    gnumake

    cmake

    gdb

    pkg-config


    # ------------------------------------------------------------
    # JAVA
    # ------------------------------------------------------------

    jdk21

    maven

    gradle

    jetbrains.idea


    # ------------------------------------------------------------
    # PYTHON
    # ------------------------------------------------------------

    python3

    uv


    # ------------------------------------------------------------
    # JAVASCRIPT / WEB
    # ------------------------------------------------------------

    nodejs
    


    # ------------------------------------------------------------
    # EDITORS / IDE
    # ------------------------------------------------------------

    neovim

    vscode


    # ------------------------------------------------------------
    # HYPRLAND
    # ------------------------------------------------------------
    noctalia
   

    kitty

    waybar

    rofi

    wl-clipboard

    cliphist

    swaylock

    swayidle


    # ------------------------------------------------------------
    # WAYLAND UTILITIES
    # ------------------------------------------------------------

    wlogout

    grim
    slurp

    swappy

    brightnessctl

    playerctl


    # ------------------------------------------------------------
    # TERMINAL / SYSTEM UTILITIES
    # ------------------------------------------------------------

    btop

    fastfetch

    htop

    pciutils
    usbutils

    lsof

    killall


    # ------------------------------------------------------------
    # FILE MANAGERS
    # ------------------------------------------------------------

    # Thunar
    thunar
    thunar-volman

    tumbler


    # ------------------------------------------------------------
    # DESKTOP UTILITIES
    # ------------------------------------------------------------

    xdg-utils

    xdg-user-dirs

    desktop-file-utils

    shared-mime-info


    # ------------------------------------------------------------
    # GUI / GTK UTILITIES
    # ------------------------------------------------------------

    gtk3

    gtk4


    # ------------------------------------------------------------
    # NETWORK UTILITIES
    # ------------------------------------------------------------

    networkmanagerapplet

    dnsutils

    iproute2

    inetutils


    # ------------------------------------------------------------
    # DISK / STORAGE UTILITIES
    # ------------------------------------------------------------

    gparted

    


    # ------------------------------------------------------------
    # DOCUMENT / PDF
    # ------------------------------------------------------------

    evince


    # ------------------------------------------------------------
    # BROWSER
    # ------------------------------------------------------------

    brave


    # ------------------------------------------------------------
    # SYSTEM MONITORING
    # ------------------------------------------------------------

    lm_sensors

    


    # ------------------------------------------------------------
    # YOUR EXISTING GNOME UTILITIES
    # ------------------------------------------------------------

    gnome-tweaks

    gnome-extension-manager
  ];


  # ============================================================
  # ENVIRONMENT VARIABLES
  # ============================================================

  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    WLR_NO_HARDWARE_CURSORS = "1";
    XCURSOR_THEME = "Adwaita";
    XCURSOR_SIZE = "24";
    NIRI_DISABLE_HARDWARE_CURSORS = "1";
  };


  # ============================================================
  # USER
  # ============================================================

  users.users.khush = {
    isNormalUser = true;

    description = "Khush";

    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "audio"
    ];
  };


  # ============================================================
  # NIX SETTINGS
  # ============================================================

  nix.settings = {
  download-buffer-size = 67108864; # 64 MiB
  max-substitution-jobs = 32;
  http-connections = 50;
  download-attempts = 5;
  connect-timeout = 10;
};
  


  # ============================================================
  # NIX GARBAGE COLLECTION
  # ============================================================

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };


  # ============================================================
  # AUTOMATIC STORE OPTIMISATION
  # ============================================================

  nix.settings.auto-optimise-store = true;


  # ============================================================
  # PROGRAMMING SHELL
  # ============================================================

  programs.bash.shellAliases = {
    ll = "ls -lah";
    la = "ls -A";
    ".." = "cd ..";

    rebuild = "sudo nixos-rebuild switch";
    update = "sudo nix-channel --update && sudo nixos-rebuild switch";
  };


  # ============================================================
  # SYSTEM VERSION
  # ============================================================

  system.stateVersion = "26.05";
}
