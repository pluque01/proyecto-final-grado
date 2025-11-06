{
  lib,
  pkgs,
  config,
  globals,
  ...
}: let
  networkDefs = {
    frontnet = {driver = "bridge";};
    backnet = {
      driver = "bridge";
      internal = true;
    };
    monitoring = {driver = "bridge";};
  };

  traefik = import ./traefik.nix {
    inherit lib pkgs config globals;
    networks = ["frontnet"];
  };
  nextcloud = import ./nextcloud/nextcloud.nix {
    inherit lib globals;
    networks = ["frontnet"];
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
        graphroot = "${globals.dataFolder}/${globals.containerUser}/storage";
      };
    };
  };

  imports = [
    traefik
    nextcloud
  ];
}