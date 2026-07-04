{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        # IMPORTANT: match physical device name to avoid wiping the wrong disk
        device = "/dev/vda";
        content = {
          type = "gpt";
          partitions = {
            # EFI partition
            ESP = {
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };

            # LUKS encrypted partition
            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "crypted";
                askPassword = true;

                # BTRFS filesystem inside LUKS
                content = {
                  type = "btrfs";
                  extraArgs = [ "-f" ]; # force format if the filesystem already exists
                  subvolumes = {
                    "/root" = {
                      mountpoint = "/";
                      mountOptions = [ "compress=zstd", "noatime" ];
                    };
                    "/nix" = {
                      mountpoint = "/nix";
                      mountOptions = [ "compress=zstd", "noatime" ];
                    };
                    "/home" = {
                      mountpoint = "/home";
                      mountOptions = [ "compress=zstd", "noatime" ];
                    };
                    "/var/log" = {
                      mountpoint = "/var/log";
                      mountOptions = [ "compress=zstd", "noatime" ];
                    };
                    "/var/lib" = {
                      mountpoint = "/var/lib";
                      mountOptions = [ "compress=zstd", "noatime" ];
                    };
                    "/swap" = {
                      mountpoint = "/swap";
                      swap.swapfile.size = "8G";
                    };
                    # Future-proofing: Persist subvolume for impermanence
                    "/persist" = {
                      mountpoint = "/persist";
                      mountOptions = [ "compress=zstd", "noatime" ];
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}