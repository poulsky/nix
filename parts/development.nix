{ self, ... }:

{
  flake.nixosModules.development = { pkgs, ... }: {
    virtualisation.podman = {
      enable = true;
      defaultNetwork.settings.dns_enabled = true;
    };

    virtualisation.docker = {
      enable = true;
    };

    # For devcontainers
    virtualisation.containers.registries.search = [ "docker.io" ];

    users.users.mikkel.extraGroups = [ "docker" "podman" ];

    programs.nix-ld = {
      enable = true;
      libraries = with pkgs; [
          # Basic compilers/runtime requirements
          stdenv.cc.cc
          zlib
          glib
          openssl
          libglvnd
          alsa-lib
          uuid
          # X11 UI libraries typically expected by debuggers
          xorg.libX11
          xorg.libXcursor
          xorg.libXrandr
          xorg.libXi
        ];
      };
    };
  };
}