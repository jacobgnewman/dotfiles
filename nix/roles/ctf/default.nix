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
    pkgs-stable.ghidra
    pwndbg
    imhex
    # (qt6Packages.callPackage ./binja {})
    qemu
  ];
}
