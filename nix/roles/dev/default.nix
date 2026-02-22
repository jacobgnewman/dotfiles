# Any language specific tooling that I want available without defining a project specific flake
# TODO Make this more module like ¯\_(ツ)_/¯
{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # Utils
    direnv # automatic dev-env loading
    jujutsu # git compat VCS system
    jjui # nice tui for jj
    git
    gh

    # C & Friends
    libgcc
    gcc
    llvm
    binutils
    clang

    # Debugger tools
    rr

    # go
    go

    # nix stuff
    nixd
    nixfmt

    # Python
    uv

    # Racket
    racket

    # Rust
    rustup

    # Sagemath
    # sage

    # Typst
    typst

    # sw libraries
    pkg-config
    zlib
  ];
}
