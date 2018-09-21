{ stdenv, requireFile, unzip,  ... }:

let
  name = "latex-tuddesign-fonts";
  version = "0.0.20090806";
in

stdenv.mkDerivation {
  inherit name version;

  pname = name;
  tlType = "run";

  srcs = [
    (requireFile {
      name = "tudfonts-tex_${version}.zip";
      url = "http://exp1.fkp.physik.tu-darmstadt.de/tuddesign/latex/tudfonts-tex/tudfonts-tex_${version}.zip";
      sha256 = "0bvyh73zhc33sxn26mgn9vw7n594ds3y4h3nmkp363cqnnnzxrwl";
    })
    # TODO maps?
  ];

  nativeBuildInputs = [ unzip ];

  unpackCmd = "unzip $curSrc";

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/share/texmf
    cp -R {fonts,tex} $out/share/texmf
  '';

  meta = with stdenv.lib; {
    description = "Fonts of the corporate-design for LaTeX from Technische Universität Darmstadt";
    homepage = http://exp1.fkp.physik.tu-darmstadt.de/tuddesign/;
  };
}
