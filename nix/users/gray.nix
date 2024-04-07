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
        just
        alejandra
        direnv
        git
        gh
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
      ];
    };
  };
}
