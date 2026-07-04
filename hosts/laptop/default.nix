{ pkgs, stateVersion, ... }:
{
  system.stateVersion = stateVersion;

    boot.initrd.luks.devices."crypted" = {
    device = "/dev/nvme0n1p2";
    preLVM = true;
    cryptenrollArgs = [ "--tpm2-device=auto" ];
  };

  users.users.mikkel = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };
}