{config, ...}: {

  services.syncthing = {
    enable = true;
    user = "gray";
    guiAddress = "127.0.0.1:8384";
    dataDir = "/home/gray/sync"; # Default folder for new synced folders
    configDir = "/home/gray/.config/syncthing"; # Folder for Syncthing's settings and keys
  };
  
  services.nginx.virtualHosts."syncthing.mountainrose.ca" = {
    enableACME = true;
    acmeRoot = null;
    forceSSL = true;
    locations."/" = {
      proxyPass = "http://127.0.0.1:8384";
    };
  };

}