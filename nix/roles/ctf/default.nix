{
  pkgs,
  pkgs-stable,
  ...
}: {
  environment.systemPackages = with pkgs; [
    nmap
    nasm
    sage
    # binwalk
    burpsuite
    wireshark
    wabt
    pkgs-stable.ghidra
    # pwndbg
    imhex
    # (qt6Packages.callPackage ./binja {})
    qemu
  ];
}
