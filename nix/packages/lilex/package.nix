{
  lib,
  stdenvNoCC,
  fetchzip,
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "Lilex";
  version = "2.6";

  src = fetchzip {
    url = "https://github.com/mishamyrt/Lilex/releases/download/${finalAttrs.version}/Lilex.zip";
    stripRoot = false;
    # hash = "sha256-MMmS1yjhy50fgMK5h0526YKRfQJuOcEAHqxn9rhUwCc=";
  };

  installPhase = ''
    runHook preInstall
    install -D -m 444 *.ttf -t $out/share/fonts/truetype
    runHook postInstall
  '';

  meta = {
    #changelog = "https://github.com/rektdeckard/departure-mono/releases/tag/v${finalAttrs.version}";
    description = "The font for developers";
    homepage = "https://lilex.myrt.co/";
    license = lib.licenses.ofl;
    platforms = lib.platforms.all;
    # maintainers = with lib.maintainers; [ ];
  };
})
