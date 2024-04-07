{config, ...}: {
  # Base Proxy
  services.nginx.virtualHosts."mountainrose.ca" = {
    enableACME = true;
    acmeRoot = null;
    forceSSL = true;
    locations."/" = {
      proxyPass = "http://127.0.0.1:8082";
    };
  };

  services.homepage-dashboard = {
    enable = true;

    bookmarks = [
      {
        dev = [
          {
            github = [
              {
                abbr = "GH";
                href = "https://github.com/jacobgnewman";
                icon = "github-light.png";
              }
            ];
          }
          {
            "homepage docs" = [
              {
                abbr = "HD";
                href = "https://gethomepage.dev";
                icon = "homepage.png";
              }
            ];
          }
        ];
      }
      {
        nix = [
          {
            "Nixpkgs" = [
              {
                href = "https://search.nixos.org/packages";
                icon = "https://nixos.wiki/favicon.png";
              }
            ];
          }
          {
            "NixosOptions" = [
              {
                href = "https://search.nixos.org/options?";
                icon = "https://nixos.wiki/favicon.png";
              }
            ];
          }
          {
            "Nixos Wiki" = [
              {
                href = "https://nixos.wiki/";
                icon = "https://nixos.wiki/favicon.png";
              }
            ];
          }
        ];
      }
    ]; # bookmarks

    services = [
      {
        infra = [
          {
            "Syncthing - MountainRange" = {
              description = "syncthing ui for MR";
              icon = "syncthing.png";
              href = "https://syncthing.mountainrose.ca";
            };
          }
          {
            "Forgejo" = {
              description = "Personal Git Server";
              icon = "forgejo.png";
              href = "https://git.mountainrose.ca";
            };
          }
          {
            "Vaultwarden" = {
              description = "Vaultwarden";
              icon = "vaultwarden.png";
              href = "https://vaultwarden.mountainrose.ca";
            };
          }
        ];
      }
    ]; # services

    widgets = [
      {
        search = {
          provider = "google";
          target = "_blank";
        };
      }
      {
        resources = {
          label = "system";
          cpu = true;
          memory = true;
        };
      }
      {
        resources = {
          label = "storage";
          disk = ["/"];
        };
      }
      {
        openmeteo = {
          label = "Vancouver";
          timezone = "America/Vancouver";
          units = "metric";
        };
      }
    ]; # widgets

    settings = {
      title = "Home";
      background = "https://images.unsplash.com/photo-1502252430442-aac78f397426?auto=format&fit=crop&w=2560&q=80";
      headerStyle = "clean";
      layout = {
        infra = {
          style = "row";
          columns = 4;
        };
        dev = {
          style = "row";
          columns = 3;
        };
        nix = {
          style = "row";
          columns = 1;
        };
      };
    };
  };
}
