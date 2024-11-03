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
    imhex
    (qt6Packages.callPackage ./binja {})
  ];
}
