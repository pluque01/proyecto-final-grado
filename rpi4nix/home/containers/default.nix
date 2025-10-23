{...}: {
  home.stateVersion = "25.05";

  services.podman = {
    enable = true;
    autoUpdate = {
      enable = true;
      onCalendar = "*-*-* 00:00:00";
    };
  };
}
