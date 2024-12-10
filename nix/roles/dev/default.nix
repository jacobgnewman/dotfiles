{
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # C & Friends
    libgcc
    gcc
    llvm
    clang

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

    # Prolog
    swi-prolog

    # Python
    python312Full
    python312Packages.pip
    pyright

    # Racket
    racket

    # Rust
    # rustup

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
