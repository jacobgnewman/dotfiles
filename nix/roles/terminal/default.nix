{
  pkgs,
  ...
}: {

  imports = [
    ./fish.nix
  ];

  environment.systemPackages = with pkgs; [
    atuin # sync'd shell history
    #utilities
    bore-cli # NAT tunneling
    coreutils
    dust # better graphical du
    lazydocker # TUI for docker stuff
    fzf # fuzzy finder
    fd # nice find alternative with better defaults
    google-cloud-sdk # GCP TUI controller
    impala
    jq # cmdline json parser
    jujutsu # git compat VCS
    kubectl # kubernetes CLI
    llvmPackages.bintools # binary utilities
    ncspot
    openvpn # VPN util
    postgresql
    ripgrep # fast grep
    wl-clipboard # clipboard cli interface
    wineWowPackages.unstableFull # wine emulation layer for windows bin's
    wireguard-tools
    zoxide # improved z
  ];
}
