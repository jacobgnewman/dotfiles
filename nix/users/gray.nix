{
  config,
  pkgs,
  lib,
  ...
}: {
  config = {
    users.users.gray = {
      isNormalUser = true;
      description = "gray";
      extraGroups = ["networkmanager" "wheel" "docker"];
      packages = with pkgs; [
        alejandra
        btop
        bat
        direnv
        git
        gh
        just
        lazygit
        helix
        python3
        tmux
        unzip
        binutils
        gdb
        nil
      ];

      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDOlBcrO5Tyq8ESc6uavW7Lnq4IWEC+YyG5KIAfn7r85"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILF9GkipwZHZxHQiE8HG+bSbjjpEOs31Uclakm8d7CTW"
      ];
    };
  };
}
