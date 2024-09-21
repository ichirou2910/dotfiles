{ pkgs, unzip }:
pkgs.stdenv.mkDerivation {
  name = "windows";
  src = ./assets/fonts.zip;

  nativeBuildInputs = [ unzip ];

  # inherit name src;
  sourceRoot = ".";

  installPhase = ''
    rm -rf __MACOSX/
    DEST="$out/share/fonts/Windows"
    mkdir -p "$DEST"
    find . \( -name '*.ttf' -o -name '*.otf' \) -print0 | xargs -0 cp -t "$DEST"
  '';
}
