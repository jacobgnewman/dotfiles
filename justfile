
default:
    @echo "what do you want to do?"

dusk: 
    darwin-rebuild switch --flake ~/dotfiles/nix/machines/dusk/.#dusk

# rebuild mountainrange
mountain: 
    sudo nixos-rebuild --flake ~/dotfiles/nix/machines/mountainrange/.#mountainrange switch

badger:
    sudo nixos-rebuild --flake ~/dotfiles/nix/machines/badger/.#badger switch


