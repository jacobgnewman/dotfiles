{pkgs, ...}: {
  imports = [
    ./fish.nix
  ];

  environment.systemPackages = with pkgs; [
    atuin # sync'd shell history
    azure-cli
    bat
    btop
    bore-cli # NAT tunneling
    # binutils
    direnv
    dust # better graphical du
    lazydocker # TUI for docker stuff
    lazygit # TUI git
    file
    fzf # fuzzy finder
    fd # nice find alternative with better defaults
    google-cloud-sdk # GCP TUI controller
    jq # cmdline json parser
    jujutsu # git compat VCS
    kubectl # kubernetes CLI
    litecli # sqlite cli
    ncspot
    openvpn # VPN util
    pgcli
    postgresql
    pdfgrep # what it says on the tin
    ripgrep # fast grep
    twm
    pdfgrep
    unzip
    wireguard-tools
    zoxide # improved z
    zip
  ];
}
