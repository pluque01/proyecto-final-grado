{
  lib,
  config,
  networks ? [],
  globals,
}: let
  name = "nextcloud";
  host = globals.mkServiceHost name;

  # Create a data directory for persistent storage
  mainDataDir = "${globals.dataFolder}/${globals.containerUser}/${name}";
  nextcloudDataDir = "${mainDataDir}/data";
  mariadbDataDir = "${mainDataDir}/db";
in {
  home.activation.ensureNextcloudDirs = lib.hm.dag.entryAfter ["writeBoundary"] ''
    mkdir -p ${nextcloudDataDir}
    mkdir -p ${mariadbDataDir}
  '';

  services.podman.containers."${name}-db" = {
    image = "docker.io/library/mariadb:latest";

    network = ["backnet"];

    environment = {
      OVERWRITEHOST = host;
      OVERWRITEPROTOCOL = "https";
      OVERWRITECLIURL = "https://${host}";
    };

    environmentFile = ["/run/secrets/rendered/nextcloud-db.env"];

    volumes = [
      "${mariadbDataDir}:/var/lib/mysql"
    ];

    labels = {
      "io.containers.autoupdate" = "registry";
    };

    extraConfig = {
      Service = {
        Restart = "unless-stopped";
      };
    };
  };

  services.podman.containers.${name} = {
    image = "docker.io/library/nextcloud:30-apache";

    network = networks ++ ["backnet"];

    # Use sops template from system-level configuration
    environmentFile = ["/run/secrets/rendered/nextcloud.env"];

    volumes = [
      "${nextcloudDataDir}:/var/www/html"
    ];

    # Traefik labels for automatic discovery
    labels = {
      "io.containers.autoupdate" = "registry";
      "traefik.enable" = "true";
      "traefik.http.routers.${name}.rule" = "Host(`${host}`)";
      "traefik.http.routers.${name}.tls" = "true";
      "traefik.http.routers.${name}.entrypoints" = "websecure";
      "traefik.http.routers.${name}.tls.certresolver" = "duckdns";
    };

    extraConfig = {
      Service = {
        Restart = "unless-stopped";
      };
    };
  };
}
