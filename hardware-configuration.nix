{
  config,
  lib,
  pkgs,
  modulesPath,
  globals,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = ["xhci_pci"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = [];
  boot.extraModulePackages = [];

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/44444444-4444-4444-8888-888888888888";
      fsType = "ext4";
    };
    ${globals.dataFolder} = {
      device = "/dev/disk/by-uuid/ea71b9c4-c601-4fb0-80fc-04649f6cd3a5";
      fsType = "ext4";
      options = ["noatime" "nofail"];
      neededForBoot = false;
    };
  };

  swapDevices = [];

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
}
