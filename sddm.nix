{ config, lib, pkgs, ... }: let 
    sddm-astronaut = pkgs.sddm-astronaut.override {
        themeConfig = {
            Background = toString /etc/nixos/Background.png;
        };
    };
in {
  services.displayManager.sddm = {
    wayland.enable = true;
    enable = true;
    theme = "sddm-astronaut-theme";
    package = pkgs.kdePackages.sddm;
    extraPackages = with pkgs; [
      sddm-astronaut
    ];
  };

  environment.systemPackages = with pkgs; [
    sddm-astronaut
    kdePackages.qtmultimedia
  ];
}
