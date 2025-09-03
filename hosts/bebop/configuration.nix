{ config, lib, pkgs, inputs, ... }:
{
    imports = [
        ./hardware-configuration.nix
    ];
    boot.loader.grub.extraEntries = ''
            menuentry 'Windows 11' {
              search --fs-uuid --no-floppy --set=root 846B-6075
              chainloader /EFI/Microsoft/Boot/bootmgfw.efi
            }
        '';
    networking.hostName = "bebop";
    programs.steam.enable = true;
}
