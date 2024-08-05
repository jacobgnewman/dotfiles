{
  pkgs,
  pkgs-stable,
  ...
}: {
  environment.systemPackages = with pkgs; [
    nmap
    binwalk
    wireshark
    ghidra
    pkgs-stable.imhex
    (qt6Packages.callPackage ./binja {})
  ];
}
