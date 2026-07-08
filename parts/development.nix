{ self, ... }:

{
  flake.nixosModules.development = { pkgs, ... }: {
    virtualisation.podman = {
      enable = true;
      dockerCompat = true;
      dockerSocket.enable = true;
      defaultNetwork.settings.dns_enabled = true;

      autoPrune = {
        enable = true;
        dates = "weekly";
      };
    };

    # For devcontainers
    virtualisation.containers.registries.search = [ "docker.io" ];

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
}