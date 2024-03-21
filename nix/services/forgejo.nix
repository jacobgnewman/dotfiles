{config, ...}: {

  services.forgejo = {
    enable = true;
    settings.server.DOMAIN = "git.mountainrose";
    settings.server.HTTP_PORT = 3000;
  };
  
  services.nginx.virtualHosts."git.mountainrose.ca" = {
    enableACME = true;
    acmeRoot = null;
    forceSSL = true;
    locations."/" = {
      proxyPass = "http://127.0.0.1:3000";
    };
  };

}