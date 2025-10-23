{
  lib,
  networks ? [],
  hostname,
}: let
  mainDataDir = "/mnt/data/containers/nextcloud";
  nextcloudDataDir = "${mainDataDir}/data";
  mariadbDataDir = "${mainDataDir}/db";
in {
  home.activation.ensureNextcloudDirs = lib.hm.dag.entryAfter ["writeBoundary"] ''
    mkdir -p ${nextcloudDataDir}
    mkdir -p ${mariadbDataDir}

    install -m 600 ${./nextcloud.env} ${mainDataDir}/nextcloud.env
    install -m 600 ${./db.env} ${mainDataDir}/db.env
  '';

  services.podman.containers.nextcloud-db = {
    image = "mariadb:latest";

    network = ["backnet"];

    environmentFile = ["${mainDataDir}/db.env"];

    volumes = [
      "${mariadbDataDir}:/var/lib/mysql"
    ];

    extraConfig = {
      Service = {
        Restart = "unless-stopped";
      };
    };
  };

  services.podman.containers.nextcloud = {
    image = "nextcloud:30-apache";

    network = networks ++ ["backnet"]; # Also needs to be on backnet to reach the database

    environmentFile = ["${mainDataDir}/nextcloud.env"];

    volumes = [
      "${nextcloudDataDir}:/var/www/html"
    ];

    labels = {
      "traefik.enable" = "true";
      "traefik.http.routers.nextcloud.rule" = "Host(`${hostname}`)";
      "traefik.http.services.nextcloud.loadbalancer.server.port" = "80";
    };

    extraConfig = {
      Service = {
        Restart = "unless-stopped";
      };
    };
  };
}