{
  description = "NixOS Raspberry Pi configuration flake";
  inputs = {
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {
    self,
    nixpkgs,
    nixos-hardware,
    home-manager,
  } @ inputs: let
    globals = {
      containerUser = "containers";
      dataFolder = "/mnt/data";
      hostname = "rpi4.local";
      mkServiceHost = service: "${service}.${globals.hostname}";
    };
  in {
    nixosConfigurations = {
      rpi4 = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        specialArgs = {inherit globals;};
        modules = [
          ./configuration.nix
          ./hardware-configuration.nix
          nixos-hardware.nixosModules.raspberry-pi-4
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {inherit globals;};

              users.${globals.containerUser} = {
                imports = [./home/containers];
              };
            };
          }
        ];
      };
    };
  };
}
