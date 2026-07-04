{ inputs, ... }

{
  flake.nixosConfigurations = {
    desktop = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        inputs.disko.nixosModules.disko
        (import ../disko.nix { device = "/dev/vda"; swapSize = "8G"; })
      ];
    };

    laptop = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        inputs.disko.nixosModules.disko
        (import ../disko.nix { device = "/dev/vda"; swapSize = "16G"; })
      ];
    };
  };
}