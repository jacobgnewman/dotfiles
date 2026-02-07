# Any packages that are nice for interactive terminal use
{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # VPN utils
    openvpn
    wireguard-tools

    # Terminal QOL tools
    bat # cat with syntax highlighting
    btop # better htop
    dust # better graphical du
    fd # nice find alternative with better defaults
    file # info about files in directory
    fzf # fuzzy finder
    jq # cmdline json parser
    ripgrep # fast grep
    socat # host command on port
    tree # show a 'tree' view of current directory
    tmux # terminal multiplexer
    zoxide # fuzzy cd with history

    # compression utils
    zip
    unzip
  ];
}
