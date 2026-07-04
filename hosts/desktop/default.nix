{ pkgs, stateVersion, ... }:

{
  system.stateVersion = stateVersion;

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
}