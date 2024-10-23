
default:
    @echo "what do you want to do?"

fern:
    sudo nixos-rebuild switch --flake ~/dotfiles/nix/machines/fern/.#fern

fern-use-badger:
    sudo nixos-rebuild switch --flake ~/dotfiles/nix/machines/fern/.#fern --no-build-nix --build-host "badger"

fern-update-flake:
    cd nix/machines/fern && sudo nix flake update
    #sudo nixos-rebuild switch --flake ~/dotfiles/nix/machines/fern/.#fern

dusk: 
    darwin-rebuild switch --flake ~/dotfiles/nix/machines/dusk/.#dusk

ember:
    sudo nixos-rebuild switch -I nixos-config=~/dotfiles/nix/machines/ember/configuration.nix

cedar:
    sudo nixos-rebuild switch -I nixos-config=/home/gray/dotfiles/nix/machines/cedar/configuration.nix

# rebuild mountainrange
mountain: 
    sudo nixos-rebuild --flake ~/dotfiles/nix/machines/mountainrange/.#mountainrange switch

badger:
    sudo nixos-rebuild --flake ~/dotfiles/nix/machines/badger/.#badger switch

clean-nix:
    sudo nix-collect-garbage -d

