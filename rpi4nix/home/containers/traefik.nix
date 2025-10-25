{
  pkgs,
  config,
  networks ? [],
}: let
  traefikConfig = pkgs.writeText "traefik.yml" ''
    api:
      insecure: true
      dashboard: true
    entryPoints:
      web:
        address: ":80"
    providers:
      docker:
        endpoint: "unix:///var/run/docker.sock"
        network: "${builtins.elemAt networks 0}"
    log:
      level: DEBUG

    accessLog:
      filePath: "/var/log/traefik/access.log"
      bufferingSize: 100
  '';
in {
  services.podman.containers.traefik = {
    image = "traefik:latest";

    network = networks;

    ports = ["80:80" "443:443" "8080:8080"];

    volumes = [
      "${traefikConfig}:/etc/traefik/traefik.yml:ro"
      "/run/user/1001/podman/podman.sock:/var/run/docker.sock"
    ];

    extraConfig = {
      Service = {
        Restart = "always";
      };
    };
  };
}