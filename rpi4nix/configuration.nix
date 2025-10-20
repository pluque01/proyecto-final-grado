{pkgs, ...}: {
  config = {
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
    users.users.containers = {
      isNormalUser = true;
      description = "Dedicated user for rootless Podman containers";
      home = "/home/containers";
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

    # Allow ssh in
    services.openssh.enable = true;

    networking = {
      hostName = "rpi4";
      networkmanager.enable = true;
    };

    system = {
      stateVersion = "25.05";
    };
  };
}
