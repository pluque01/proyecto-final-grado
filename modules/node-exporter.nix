{pkgs, ...}: let
  port = 9100;
in {
  services.prometheus.exporters.node = {
    enable = true;
  };
}
