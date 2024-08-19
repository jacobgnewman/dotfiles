{
  pkgs,
  pkgs-stable,
  ...
}: {
  environment.systemPackages = with pkgs; [
    nmap
    binwalk
    wireshark
    wabt
    ghidra
    pwndbg
    pkgs-stable.imhex
    (qt6Packages.callPackage ./binja {})
  ];
}
