{
  pkgs,
  ...
}: {

  imports = [
    ./fish.nix
  ];

  environment.systemPackages = with pkgs; [
    atuin # sync'd shell history
    bat
    btop
    bore-cli # NAT tunneling
    coreutils
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
    llvmPackages.bintools # binary utilities
    ncspot
    openvpn # VPN util
    postgresql
    ripgrep # fast grep
    wireguard-tools
    zoxide # improved z
  ];
}
