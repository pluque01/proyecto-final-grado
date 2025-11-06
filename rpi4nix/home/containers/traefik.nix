{
  lib,
  pkgs,
  config,
  networks ? [],
  globals,
}: let
  name = "traefik";
  mainDataDir = "${globals.dataFolder}/${globals.containerUser}/${name}";
  traefikConfig = pkgs.writeText "traefik.yml" ''
    api:
      dashboard: true
    entryPoints:
      web:
        address: ":80"
        http:
          redirections:
            entryPoint:
              to: websecure
              scheme: https
      websecure:
        address: ":443"
        http:
          tls:
            certResolver: duckdns
            domains:
              - main: ${globals.hostname}
                sans:
                  - '*.${globals.hostname}'
    providers:
      docker:
        endpoint: "unix:///var/run/docker.sock"
        network: "${builtins.elemAt networks 0}"
    log:
      level: DEBUG

    accessLog:
      filePath: "/var/log/traefik/access.log"
      bufferingSize: 100

    certificatesResolvers:
      duckdns:
        acme:
          email: ${globals.letsEncryptEmail}
          storage: acme.json
          dnsChallenge:
            provider: duckdns
            delayBeforeCheck: 120
            resolvers:
              - "1.1.1.1:53"
              - "8.8.8.8:53"
  '';
in {
  home.activation.ensureAcme = lib.hm.dag.entryAfter ["writeBoundary"] ''
    mkdir -p ${mainDataDir}
    if [ ! -f ${mainDataDir}/acme.json ]; then
      install -m 600 /dev/null ${mainDataDir}/acme.json
    else
      chmod 600 ${mainDataDir}/acme.json
    fi
  '';
  services.podman.containers.traefik = {
    image = "traefik:latest";

    network = networks;

    ports = ["80:80" "443:443" "8080:8080"];

    environmentFile = ["/run/secrets/rendered/duckdns.env"];

    volumes = [
      "${traefikConfig}:/etc/traefik/traefik.yml:ro"
      "/run/user/1001/podman/podman.sock:/var/run/docker.sock"
      "${mainDataDir}/acme.json:/acme.json"
    ];

    extraConfig = {
      Service = {
        Restart = "always";
      };
    };
  };
}