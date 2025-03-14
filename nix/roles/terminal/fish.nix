{pkgs, ...}: {
  programs.fish.enable = true;
  environment.systemPackages = with pkgs; [
    fishPlugins.done # fish completion time
    # fishPlugins.pure # fish prompt
    # fishPlugins.fzf-fish # fzf fish integration
    fishPlugins.forgit # interactive git commands
    # fishPlugins.hydro # git status
    fishPlugins.z # somewhat fzf like cd
    fishPlugins.grc
    grc # generic colorizer
  ];
}
