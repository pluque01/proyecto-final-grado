{
  lib,
  networks ? [],
  hostname,
}: let
  nextcloudDataDir = "/mnt/data/containers/nextcloud/data";
  mariadbDataDir = "/mnt/data/containers/nextcloud/db";
in {
  home.activation.ensureNextcloudDirs = lib.hm.dag.entryAfter ["writeBoundary"] ''
    mkdir -p ${nextcloudDataDir}
    mkdir -p ${mariadbDataDir}
  '';

  services.podman.containers.nextcloud-db = {
    image = "mariadb:latest";

    network = ["backnet"];

    environment = {
      MYSQL_DATABASE = "nextcloud";
      MYSQL_USER = "nextcloud";
      MYSQL_PASSWORD = "change_me";
      MYSQL_ROOT_PASSWORD = "change_me";
    };

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

    environment = {
      MYSQL_HOST = "nextcloud-db";
      MYSQL_DATABASE = "nextcloud";
      MYSQL_USER = "nextcloud";
      MYSQL_PASSWORD = "change_me"; 
      NEXTCLOUD_ADMIN_USER = "admin";
      NEXTCLOUD_ADMIN_PASSWORD = "change_me";
      NEXTCLOUD_TRUSTED_DOMAINS = "nextcloud.localhost";
    };

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