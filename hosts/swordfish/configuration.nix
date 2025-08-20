{ config, lib, pkgs, inputs, ... }:
{
    imports = [
        ./hardware-configuration.nix
    ];
    networking.hostName = "swordfish";

    services.tlp = {
        enable = true;
    };

    environment.systemPackages = with pkgs; [
        brightnessctl
    ];
}
