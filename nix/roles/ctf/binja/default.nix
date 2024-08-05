{
  stdenv,
  autoPatchelfHook,
  makeWrapper,
  unzip,
  libGL,
  wayland,
  qt6,
  wrapQtAppsHook,
  python310,
  glib,
  fontconfig,
  dbus,
}:
stdenv.mkDerivation {
  name = "binary-ninja";
  buildInputs = [autoPatchelfHook makeWrapper unzip wayland libGL qt6.full qt6.qtbase python310 stdenv.cc.cc.lib glib fontconfig dbus];
  src = /home/gray/dotfiles/dotbin/binaryninja_personal_linux.zip;
  nativeBuildInputs = [wrapQtAppsHook python310.pkgs.wrapPython];

  dontWrapQtApps = true;
  buildPhase = ":";
  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/opt
    cp -r * $out/opt
    chmod +x $out/opt/binaryninja
    makeWrapper $out/opt/binaryninja \
          $out/bin/binaryninja \
          --prefix "QT_QPA_PLATFORM" ":" "wayland"
  '';

  postFixup = ''
    patchelf --debug --add-needed libpython3.so \
      "$out/opt/binaryninja"
  '';
}
