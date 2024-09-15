{
  pkgs,
  pkgs-stable,
  ...
}: {
  environment.systemPackages = with pkgs; [
    nmap
    nasm
    binwalk
    burpsuite
    wireshark
    wabt
    ghidra
    pwndbg
    pkgs-stable.imhex
    (qt6Packages.callPackage ./binja {})
  ];
}
