{
  config,
  pkgs,
  lib,
  ...
}: {
  config.users.users.gray = {
    isNormalUser = true;
    description = "gray";
    extraGroups = ["networkmanager" "wheel" "docker"];
    packages = with pkgs; [
      # text editors
      neovim
      tmux
      git
      gh
      just
    ];

    shell = pkgs.fish;

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDOlBcrO5Tyq8ESc6uavW7Lnq4IWEC+YyG5KIAfn7r85"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILF9GkipwZHZxHQiE8HG+bSbjjpEOs31Uclakm8d7CTW"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC8HYF1wiHS/6Xd4fibJ/WsNK8qDaO8N9Y8JG8sXEt/+" # dusk
    ];
  };
}
