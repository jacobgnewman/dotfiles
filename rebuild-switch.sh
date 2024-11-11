#!/usr/bin/env bash
set -euxo pipefail

function rebuild_dusk {
  darwin-rebuild switch --flake ~/dotfiles/nix/machines/dusk/.#dusk
}

function rebuild_fern {
  sudo nixos-rebuild switch --flake ~/dotfiles/nix/machines/fern/.#fern
}
function rebuild_badger {
  sudo nixos-rebuild --flake ~/dotfiles/nix/machines/badger/.#badger switch
}

function rebuild_mountain {
  sudo nixos-rebuild --flake ~/dotfiles/nix/machines/mountainrange/.#mountainrange switch
}

hostname=$(hostname)

case "$hostname" in
"badger")
  rebuild_badger
  ;;
"dusk")
  rebuild_dusk
  ;;
"fern")
  rebuild_fern
  ;;
"mountain")
  rebuild_mountain
  ;;
*)
  echo "unknown host"
  ;;
esac
