{ pkgs, lib, stateVersion, inputs, ... }:

{
  imports = [
    inputs.lanzaboote.nixosModules.lanzaboote
  ];

  system.stateVersion = stateVersion;

  boot.initrd.luks.devices."crypted" = {
    device = "/dev/vda2";
    preLVM = true;
    crypttabExtraOpts = [ "--tpm2-device=auto" ];
  };

  nixpkgs.config.allowUnfree = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  programs.gamemode.enable = true;

  programs.gamescope = {
    enable = true;
    enableWsi = true;
    capSysNice = true;
  };

  users.users.mikkel = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };
}