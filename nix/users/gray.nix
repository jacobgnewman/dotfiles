{ config, pkgs, lib, ...}: {
  config = {
    users.users.gray = {
    isNormalUser = true;
    description = "gray";
    extraGroups = ["networkmanager" "wheel" "docker"];
    packages = with pkgs; [
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
      pwndbg
      nil
    ];
  };
  };
}