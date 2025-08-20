# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:
{
    imports =
        [ # Include the results of the hardware scan.
            ./nvidia.nix
            ./sddm.nix
        ];

    nixpkgs.config.allowUnfree = true;
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # Use the systemd-boot EFI boot loader.

    boot.loader = {
        systemd-boot.enable = false;
        efi.canTouchEfiVariables = true;
        grub = {
            enable = true;
            useOSProber = true;
            copyKernels = true;
            efiSupport = true;
            devices = ["nodev"];
        };
    };

    networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

    # Set your time zone.
    time.timeZone = "America/Montreal";

    environment.pathsToLink = [ "/libexec" ];

    # Enable the X11 windowing system.
    services.xserver.enable = false;

    programs.hyprland = {
        enable = true;
        withUWSM = true;
        xwayland.enable = true;
    };

    programs.firefox.enable = true;

    # Enable sound.
    services.pipewire = {
        enable = true;
        pulse.enable = true;
    };

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.cowboy = {
        isNormalUser = true;
        extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
        packages = with pkgs; [ ];
        shell = pkgs.zsh;
    };

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
        clang
        cargo
        fastfetch
        rofi
        rofi-power-menu
        grim
        slurp
        wl-clipboard
        pavucontrol
        nodejs_24
        ripgrep
        htop
        inputs.quickshell.packages."${pkgs.system}".default
        material-symbols
        ghostty
        gpu-screen-recorder
        ffmpeg
    ];

    programs.nix-ld.enable = true;
    programs.nix-ld.libraries = with pkgs; [
        libheif
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

