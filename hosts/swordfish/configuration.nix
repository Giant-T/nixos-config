{ config, lib, pkgs, inputs, ... }:
{
    imports = [
        ./hardware-configuration.nix
    ];
    networking.hostName = "swordfish";

    services.tlp = {
        enable = true;
    };

    services.upower = {
        enable = true;
    };

    environment.systemPackages = with pkgs; [
        brightnessctl
    ];
}
