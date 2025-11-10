{...}: {
  config = {
    # Time, keyboard language, etc
    time.timeZone = "Europe/Madrid";
    i18n.defaultLocale = "es_ES.UTF-8";

    environment.systemPackages = with pkgs; [
      neovim
      git
    ];

    # User
    users.users.pi = {
      isNormalUser = true;
      password = "";
      extraGroups = [
        "wheel" # Enable 'sudo' for the user.
        "networkmanager"
      ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJACksgplBsn5m16ZRTvNzx9hjJ1llNiRN4PZUVlKAdY pablols114@gmail.com"
      ];
    };

    # Allow ssh in
    services.openssh.enable = true;

    networking = {
      hostName = "pi4";
      networkmanager.enable = true;
    };

    # This makes the build be a .img instead of a .img.zst
    sdImage.compressImage = false;

    system = {
      stateVersion = "25.05";
    };
  };
}
