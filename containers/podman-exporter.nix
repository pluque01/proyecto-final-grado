{
  pkgs,
  globals,
  ...
}: let
  name = "podman-exporter";
  port = 9882;
  inherit (globals) dataFolder;
in {
  services.podman.containers.${name} = {
    image = "quay.io/navidys/prometheus-podman-exporter:latest";
    autoStart = true;

    # Puerto expuesto para Prometheus
    ports = ["${toString port}:9882"];

    # Variables de entorno (exporter escucha el socket de Podman)
    environment = {
      CONTAINER_HOST = "unix:///run/podman/podman.sock";
    };

    # Montar el socket del Podman rootless del usuario
    # $XDG_RUNTIME_DIR suele ser /run/user/<uid>
    volumes = [
      "/run/user/1001/podman/podman.sock:/run/podman/podman.sock"
    ];

    labels = {
      "io.containers.autoupdate" = "registry";
    };

    # Opciones extra según tu comando original
    extraPodmanArgs = [
      "--userns=keep-id:uid=65534"
      "--security-opt=label=disable"
      "--name=podman-exporter"
    ];

    extraConfig = {
      Service = {
        Restart = "always";
      };
    };
  };
}
