default:
    @echo "what do you want to do?"

# rebuild nix config & switch
rs:
  ./rebuild-switch.sh

# clear nix store
clean-nix:
    sudo nix-collect-garbage -d

