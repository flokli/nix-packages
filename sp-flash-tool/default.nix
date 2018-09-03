{ stdenv, autoPatchelfHook, fetchFromGitHub, substituteAll, qt4, qmake4Hook, makeWrapper }:

let
  version = "5.1720-19";
in

stdenv.mkDerivation {
  name = "sp-flash-tool-${version}";

  src = fetchFromGitHub {
    owner = "dguidipc";
    repo = "SP-Flash-Tool-src";
    rev = "a12e2b1b1ee7b46fc25d0fc7de56e4d519213227";
    sha256 = "067bqv4703znrdy5in6ni16hr4rvsmbwx1bxk02xc0chjpfbzkbi";
  };

  nativeBuildInputs = [ qmake4Hook autoPatchelfHook makeWrapper ];
  buildInputs = [ qt4 ];

  patches = ./0001-fix-app_paths.patch;

  installPhase = ''
    install -Dm755 {.,$out/bin}/flash_tool

    install -Dm644 {Lib,$out/lib}/libflashtool.so
    install -Dm644 {Lib,$out/lib}/libflashtoolEx.so
    install -Dm644 {Lib,$out/lib}/libsla_challenge.so

    install -Dm644 {Lib,$out/share/sp-flash-tool}/MTK_AllInOne_DA.bin
    install -Dm644 {Lib,$out/share/sp-flash-tool}/Release.json
    install -Dm644 {Lib,$out/share/sp-flash-tool}/console_mode.xsd
    install -Dm644 {Lib,$out/share/sp-flash-tool}/download_scene.ini
    install -Dm644 {Lib,$out/share/sp-flash-tool}/key.ini
    install -Dm644 {Lib,$out/share/sp-flash-tool}/option.ini
    install -Dm644 {Lib,$out/share/sp-flash-tool}/update.ini

    wrapProgram $out/bin/flash_tool \
      --run "mkdir -p \$HOME/.local/share/data/sp-flash-tool;for f in $out/share/sp-flash-tool/*; do cp -nv \$f \$HOME/.local/share/data/sp-flash-tool/;done"
  '';

  meta = with stdenv.lib; {
    description = "Gemini PDA Linux flash tool";
    homepage = http://support.planetcom.co.uk/index.php/Flashing_Guide;
    platforms = [ "x86_64-linux" ];
  };
}
