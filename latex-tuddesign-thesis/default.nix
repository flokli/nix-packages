{ stdenv, fetchurl, unzip,  ... }:

let
  name = "latex-tuddesign-thesis";
  version = "0.0.20140703";
in

stdenv.mkDerivation {
  inherit name version;

  pname = name;
  tlType = "run";

  src = fetchurl {
    url = "http://exp1.fkp.physik.tu-darmstadt.de/tuddesign/latex/${name}/${name}_${version}.zip";
    sha256 = "0dj4sskac8rbrbqd0s4lmqzr8y8rihw64lfw029sjjqdv3xns3l2";
  };

  unpackCmd = "unzip $curSrc";

  nativeBuildInputs = [ unzip ];

  dontBuild = true;

  installPhase = ''
    mkdir -p $out
    cp -R {tex,doc} $out
  '';

  meta = with stdenv.lib; {
    description = "Corporate-design for LaTeX from Technische Universität Darmstadt";
    homepage = https://www.intern.tu-darmstadt.de/arbeitsmittel/corporate_design_vorlagen/index.de.jsp;
  };
}
