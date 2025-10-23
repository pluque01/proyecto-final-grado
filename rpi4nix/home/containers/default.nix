{
  lib,
  pkgs,
  config,
  ...
}: let
  host = "rpi4.local";
  networkDefs = {
    frontnet = {driver = "bridge";};
    backnet = {
      driver = "bridge";
      internal = true;
    };
    monitoring = {driver = "bridge";};
  };

  traefik = import ./traefik.nix {
    inherit config pkgs;
    networks = ["frontnet"];
  };
  nextcloud = import ./nextcloud.nix {
    inherit lib;
    networks = ["frontnet"];
    hostname = "nextcloud." + host;
  };
in {
  home.stateVersion = "25.05";

  services.podman = {
    enable = true;
    networks = networkDefs;
    autoUpdate = {
      enable = true;
      # Ejecuta el auto-update diariamente a medianoche
      onCalendar = "*-*-* 00:00:00";
    };
    settings.storage = {
      storage = {
        graphroot = "/mnt/data/containers/storage";
      };
    };
  };

  imports = [
    traefik
    nextcloud
  ];
}