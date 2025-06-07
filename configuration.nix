# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# TODO: modulariser
{ config, lib, pkgs, ... }: let 
    sddm-astronaut = pkgs.sddm-astronaut.override {
        themeConfig = {
            Background = toString ./Background.png;
        };
    };
in {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nixpkgs.config.allowUnfree = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.loader = {
    grub = {
      enable = true;
      useOSProber = true;
      copyKernels = true;
      efiSupport = true;
      devices = ["nodev"];
      extraEntries = ''
      	menuentry 'Windows 11' {
          search --fs-uuid --no-floppy --set=root 846B-6075
          chainloader /EFI/Microsoft/Boot/bootmgfw.efi
        }
      '';
    };
  };

  networking.hostName = "bebop"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "America/Montreal";

  environment.pathsToLink = [ "/libexec" ];

  # Enable the X11 windowing system.
  services.xserver = {
    enable = false;
    desktopManager = {
      xterm.enable = true;
    };
    videoDrivers = ["nvidia"];

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        rofi
	    i3lock
	    i3status-rust
      ];
    };
  };

  services.displayManager.sddm = {
    wayland.enable = true;
    enable = true;
    theme = "sddm-astronaut-theme";
    package = pkgs.kdePackages.sddm;
    extraPackages = with pkgs; [
      sddm-astronaut
    ];
  };

  

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  hardware.graphics = {
    enable = true;
  };
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;
  };

  # Enable sound.
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.cowboy = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
    ];
    shell = pkgs.zsh;
  };

  programs.firefox.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    libGL
    neovim
    tmux
    zsh 
    stow
    git
    wget
    alacritty
    eww
    timewall
    swww
    hyprlock
    hypridle
    socat
    jq
    playerctl
    adwaita-icon-theme
    discord
    clang-tools
    clang
    cargo
    fastfetch
    dunst
    sddm-astronaut
    kdePackages.qtmultimedia
  ];

  fonts.packages = with pkgs; [
    noto-fonts-emoji
    _0xproto
    nerd-fonts._0xproto
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
  };

  programs.thunar = {
    enable = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?
}

