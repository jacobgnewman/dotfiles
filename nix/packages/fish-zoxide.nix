{
  buildFishPlugin,
  fetchFromGitHub,
}:
buildFishPlugin rec {
  pname = "zoxide.fish";
  #version = "unstable-2022-04-08";

  src = fetchFromGitHub {
    owner = "kidonng";
    repo = pname;
    rev = "bfd5947bcc7cd01beb23c6a40ca9807c174bba0e";
    #sha256 = "sha256-+FUBM7CodtZrYKqU542fQD+ZDGrd2438trKM0tIESs0=";
  };
}
