{
  pkgs,
  globals,
  ...
}: {
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
