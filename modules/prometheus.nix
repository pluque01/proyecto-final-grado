{
  config,
  globals,
  ...
}: {
  services.prometheus = {
    enable = true;
    listenAddress = "0.0.0.0";
    port = 9090;
    stateDir = "prometheus2";

    globalConfig.scrape_interval = "10s"; # "1m"
    scrapeConfigs = [
      {
        job_name = "node";
        static_configs = [
          {
            targets = ["localhost:${toString config.services.prometheus.exporters.node.port}"];
          }
        ];
      }
      {
        job_name = "podman";
        static_configs = [
          {
            targets = ["localhost:9882"];
          }
        ];
      }
    ];
  };

  systemd.tmpfiles.rules = [
    "d ${globals.dataFolder}/prometheus 0755 prometheus prometheus - -"
    "L+ /var/lib/${config.services.prometheus.stateDir}/data - - - - ${globals.dataFolder}/prometheus"
  ];

  networking.firewall.allowedTCPPorts = [9090];
}
