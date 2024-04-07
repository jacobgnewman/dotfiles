{config, ...}: let
  host = "git.mountainrose.ca";
in {
  services.forgejo = {
    enable = true;
    lfs.enable = true;

    settings = {
      DEFAULT.APP_NAME = "Summit Forge";

      server = {
        DOMAIN = host;
        LANDING_PAGE = "explore";
        HTTP_PORT = 3000;
        ROOT_URL = "https://${host}";
      };

      service = {
        REQUIRE_SIGNIN_VIEW = true; # change later?
      };
    };
  };

  services.nginx.virtualHosts."${host}" = {
    enableACME = true;
    acmeRoot = null;
    forceSSL = true;
    locations."/" = {
      proxyPass = "http://127.0.0.1:3000";
    };
  };
}
