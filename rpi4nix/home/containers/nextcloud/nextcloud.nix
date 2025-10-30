{
  lib,
  networks ? [],
  globals,
}: let
  name = "nextcloud";
  host = globals.mkServiceHost name;

  mainDataDir = "${globals.dataFolder}/${globals.containerUser}/${name}";
  nextcloudDataDir = "${mainDataDir}/data";
  mariadbDataDir = "${mainDataDir}/db";
in {
  home.activation.ensureNextcloudDirs = lib.hm.dag.entryAfter ["writeBoundary"] ''
    mkdir -p ${nextcloudDataDir}
    mkdir -p ${mariadbDataDir}

    install -m 600 ${./nextcloud.env} ${mainDataDir}/${name}.env
    install -m 600 ${./db.env} ${mainDataDir}/db.env
  '';

  services.podman.containers."${name}-db" = {
    image = "mariadb:latest";

    network = ["backnet"];

    environment = {
      OVERWRITEHOST = host;
      OVERWRITEPROTOCOL = "https";
      OVERWRITECLIURL = "https://${host}";
    };

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

  services.podman.containers.${name} = {
    image = "nextcloud:30-apache";

    network = networks ++ ["backnet"]; # Also needs to be on backnet to reach the database

    environmentFile = ["${mainDataDir}/${name}.env"];

    volumes = [
      "${nextcloudDataDir}:/var/www/html"
    ];

    # Traefik labels for automatic discovery
    labels = {
      "traefik.enable" = "true";
      "traefik.http.routers.${name}.rule" = "Host(`${host}`)";
      "traefik.http.routers.${name}.tls" = "true";
      "traefik.http.routers.${name}.entrypoints" = "websecure";
      "traefik.http.routers.${name}.tls.certresolver" = "duckdns";

    extraConfig = {
      Service = {
        Restart = "unless-stopped";
      };
    };
  };
}