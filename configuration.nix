{
  config,
  pkgs,
  ...
}: {
  imports = [./hardware-configuration.nix];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [mesa pkgs.mesa.drivers vulkan-tools];
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  hardware.keyboard.zsa.enable = true;

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/Zurich";
  i18n.defaultLocale = "de_CH.UTF-8";

  services = {
    xserver = {
      enable = true;
      videoDrivers = ["intel" "modesetting"];
    };

    desktopManager.plasma6.enable = true;

    displayManager = {
      sddm = {
        enable = true;
        wayland.enable = true;
      };
      defaultSession = "plasma";
    };
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = false;
  };

  systemd.services.rtkit-daemon = {enable = true;};
  systemd.services."NetworkManager-wait-online".enable = false;

  services.fprintd.enable = true;

  environment.systemPackages = with pkgs; [
    gnumake
    grimblast
    imv
    lf
    hyprlock
    pamixer
    dunst
    libnotify
    obsidian
    unzip
    emacs
    nixd
    vim
    neofetch
    alacritty
    vlc
    libreoffice
    pipewire
    plasma5Packages.kdeconnect-kde
    steam
    neovim
    #rofi
    rofi-wayland
    firefox
    kitty
    telegram-desktop
    fprintd
    btop
    ghc
    tty-clock
    gcc
    acpi
    xdg-utils
    lshw
    smartmontools
    toybox
    dmidecode
    inxi
    alejandra
    nixfmt-classic
    tmux
    zsh
    git
    lsd
    bat
    fastfetch
    powershell
    figlet
    jdk
    vscodium
    cbonsai
    speedtest-cli
    tree
    jq
    discord
    starship
    hyprpaper
    dolphin
    feh
    waybar
    rtkit
    emacs
    wget
    polybar
    silicon
    go
    prismlauncher
    keymapp
    keymapper
    #jetbrains.goland
    wails
  ];

  users.users.joel = {
    isNormalUser = true;
    description = "Joel";
    extraGroups = ["networkmanager" "wheel"];
    packages = with pkgs; [kate];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;
  programs.firefox.enable = true;
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = false;
  };

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  programs.steam = {
  enable = true;
  remotePlay.openFirewall = true;
  dedicatedServer.openFirewall = true;
  localNetworkGameTransfers.openFirewall = true;
};

  fonts.packages = with pkgs; [nerdfonts];

  nixpkgs.config.allowUnfree = true;

  networking.firewall = {
    enable = true;
    allowedTCPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
    allowedUDPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
  };

  system.stateVersion = "24.11";
}
