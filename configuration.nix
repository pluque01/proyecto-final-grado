{
  inputs,
  pkgs,
  config,
  globals,
  ...
}: {
  imports = [
    ./modules/sops.nix
    ./modules/tailscale.nix
    ./modules/node-exporter.nix
    ./modules/prometheus.nix
    ./modules/grafana.nix
  ];

  sops = {
    defaultSopsFile = ./secrets.yaml;
    secrets = {
      tailscale_key = {};
      duckdns_token = {
        owner = globals.containerUser;
        group = "users";
        mode = "0400";
      };
      # Nextcloud secrets
      "nextcloud/mysql_password" = {
        owner = globals.containerUser;
        group = "users";
        mode = "0400";
      };
      "nextcloud/mysql_root_password" = {
        owner = globals.containerUser;
        group = "users";
        mode = "0400";
      };
      "nextcloud/admin_password" = {
        owner = globals.containerUser;
        group = "users";
        mode = "0400";
      };
    };

    templates."duckdns.env" = {
      content = ''
        DUCKDNS_TOKEN=${config.sops.placeholder."duckdns_token"}
      '';
      owner = globals.containerUser;
      group = "users";
      mode = "0400";
    };

    templates."nextcloud.env" = {
      content = ''
        MYSQL_HOST=nextcloud-db
        MYSQL_DATABASE=nextcloud
        MYSQL_USER=nextcloud
        MYSQL_PASSWORD=${config.sops.placeholder."nextcloud/mysql_password"}
        NEXTCLOUD_ADMIN_USER=admin
        NEXTCLOUD_ADMIN_PASSWORD=${config.sops.placeholder."nextcloud/admin_password"}
        NEXTCLOUD_TRUSTED_DOMAINS=${globals.mkServiceHost "nextcloud"}
      '';
      owner = globals.containerUser;
      group = "users";
      mode = "0400";
    };

    templates."nextcloud-db.env" = {
      content = ''
        MYSQL_DATABASE=nextcloud
        MYSQL_USER=nextcloud
        MYSQL_PASSWORD=${config.sops.placeholder."nextcloud/mysql_password"}
        MYSQL_ROOT_PASSWORD=${config.sops.placeholder."nextcloud/mysql_root_password"}
      '';
      owner = globals.containerUser;
      group = "users";
      mode = "0400";
    };
  };

  # Time, keyboard language, etc
  time.timeZone = "Europe/Madrid";
  i18n.defaultLocale = "es_ES.UTF-8";

  # Enable flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Do not prompt for sudo password
  security.sudo.wheelNeedsPassword = false;

  # System packages
  environment.systemPackages = with pkgs; [
    neovim
    git
    sops
  ];

  # User
  users.users.pi = {
    isNormalUser = true;
    password = "mypassword";
    extraGroups = [
      "wheel" # Enable 'sudo' for the user.
      "networkmanager"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJACksgplBsn5m16ZRTvNzx9hjJ1llNiRN4PZUVlKAdY pablols114@gmail.com"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMHu7pcYwIUsnhuGvk/nqh7+iGT5H/tp3S3XVXGy9voi pablols114@gmail.com"
    ];
  };

  users.users.${globals.containerUser} = {
    isNormalUser = true;
    description = "Dedicated user for rootless Podman containers";
    home = "/home/${globals.containerUser}";
    linger = true;
    createHome = true;
    subUidRanges = [
      {
        startUid = 100000;
        count = 65536;
      }
    ];
    subGidRanges = [
      {
        startGid = 100000;
        count = 65536;
      }
    ];
  };

  systemd.services."create-dataFolder-${globals.containerUser}" = {
    description = "Ensure ${globals.dataFolder} exists";
    wantedBy = ["multi-user.target"];
    after = ["mnt-data.mount"];
    requires = ["mnt-data.mount"];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = [
        "/run/current-system/sw/bin/mkdir -p ${globals.dataFolder}/${globals.containerUser}"
        "/run/current-system/sw/bin/chown ${globals.containerUser}:users ${globals.dataFolder}/${globals.containerUser}"
        "/run/current-system/sw/bin/chmod 0755 ${globals.dataFolder}/${globals.containerUser}"
      ];
      RemainAfterExit = true;
    };
  };

  system.autoUpgrade = {
    enable = true;
    flake = inputs.self.outPath;
    flags = [
      "--print-build-logs"
    ];
    dates = "02:00";
    randomizedDelaySec = "45min";
  };

  # Allow ssh in
  services.openssh.enable = true;

  # Allow unprileged users to map ports lower than 1024
  boot.kernel.sysctl."net.ipv4.ip_unprivileged_port_start" = 0;

  networking = {
    hostName = "rpi4";
    networkmanager.enable = true;
    firewall.allowedTCPPorts = [80 443 8080];
  };

  system = {
    stateVersion = "25.05";
  };
}
