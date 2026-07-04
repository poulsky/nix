{ inputs, ... }:

let 
  stateVersion = "26.05";
in
{
  flake.nixosConfigurations = {
    desktop = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs stateVersion; };
      modules = [
        inputs.disko.nixosModules.disko
        (import ../disko.nix { device = "/dev/vda"; swapSize = "8G"; })

        ../hosts/desktop/default.nix

        self.nixosModules.secure-boot

        inputs.home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit inputs stateVersion; };
          home-manager.users.mikkel = import ../hosts/desktop/home.nix;
        }
      ];
    };

    laptop = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs stateVersion; };
      modules = [
        inputs.disko.nixosModules.disko
        (import ../disko.nix { device = "/dev/vda"; swapSize = "16G"; })

        ../hosts/laptop/default.nix

        self.nixosModules.secure-boot

        inputs.home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit inputs stateVersion; };
          home-manager.users.mikkel = import ../hosts/laptop/home.nix;
        }
      ];
    };
  };
}