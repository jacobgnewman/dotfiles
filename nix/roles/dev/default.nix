{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # C & Friends
    libgcc
    gcc
    llvm
    clang

    # capstone
    # nrfutil
    # cmake
    # ninja
    # nrfconnect
    # nrf-command-line-tools
    # python312Packages.west
    # segger-jlink

    # Debugger tools
    rr

    # Erlang
    erlang
    erlang-ls

    # go
    go

    # Haskell
    # haskell.compiler.ghc910
    ghc
    stack
    haskell-language-server
    # cabal-install

    # javascript
    nodejs_22
    deno

    # Latex
    tectonic

    # Lua
    lua

    # fennel
    fennel-ls
    fnlfmt

    # nix
    nil
    alejandra

    # Prolog
    swi-prolog

    # Python
    python313Full
    python313Packages.pip
    pyright

    # Racket
    racket

    # Rust
    rustup

    # Sagemath
    # sage

    # Typst
    typst
    tinymist

    # sw libraries
    ffmpeg
    gmp
    gmpxx
    libclang
    mold # faster linker
    mold-wrapped
    pkg-config
    zlib
  ];
}
