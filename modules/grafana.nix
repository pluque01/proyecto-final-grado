{globals, ...}: let
  host = globals.mkServiceHost "grafana";
in {
  services.grafana = {
    enable = true;
    settings = {
      server = {
        domain = host;
        http_addr = "0.0.0.0";
      };
    };
    dataDir = "${globals.dataFolder}/grafana";
  };
  systemd.tmpfiles.rules = [
    "d ${globals.dataFolder}/grafana 0755 grafana grafana - -"
  ];
}
