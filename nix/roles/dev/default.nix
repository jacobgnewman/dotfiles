{
  pkgs,
  pkgs-stable,
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

    # Haskell
    # haskell.compiler.ghc910
    ghc
    stack
    haskell-language-server
    # cabal-install

    # Latex
    tectonic

    # Prolog
    swi-prolog

    # Python
    python312Full
    python312Packages.pip

    # Racket
    racket

    # Rust
    # rustup

    # Sagemath
    pkgs-stable.sage

    # Typst
    typst

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
