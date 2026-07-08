{ self, ... }:

{
  flake.nixosModules.workstation-system = { pkgs, lib, ... }: {
    boot.kernelParams = [
      "zswap.enabled=1"
      "zswap.compressor=zstd"
      "zswap.zpool=zsmalloc"
    ];

    nix = {
      settings = {
        auto-optimise-store = true;
      };

      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 14d";
      };
    };

    services.btrfs.autoScrub = {
      enable = true;
      interval = "weekly";
      fileSystems = [ "/" ];
    };
  };
}