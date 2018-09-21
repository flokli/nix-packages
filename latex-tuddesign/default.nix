{ stdenv, fetchurl, fetchpatch, unzip,  ... }:

let
  name = "latex-tuddesign";
  version = "1.0.20140928";
in

stdenv.mkDerivation {
  inherit name version;

  pname = name;
  tlType = "run";

  src = fetchurl {
    url = "http://exp1.fkp.physik.tu-darmstadt.de/tuddesign/latex/${name}/${name}_${version}.zip";
    sha256 = "002jh75l4q1lmy61zm0plqw8zh2h20rkhb58ah5lqqgb3g3p15a4";
  };

  patches = [(fetchpatch {
    name = "v2016-03-01.patch";
    url = "https://github.com/flokli/latex-tuddesign/commit/8261004ea6576529c10fed1180bf6502c6e231db.patch";
    sha256 = "18qiwik0v52d5wc6xc75lm0m8lyw8fj5dj5jrc3banp1xz4437pd";
  })];

  patchFlags = ["-p2"];

  nativeBuildInputs = [ unzip ];

  unpackCmd = "unzip $curSrc && rm -R doc";

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/
    cp -R {tex,doc} $out
  '';

  meta = with stdenv.lib; {
    description = "Corporate-design for LaTeX from Technische Universität Darmstadt";
    homepage = https://www.intern.tu-darmstadt.de/arbeitsmittel/corporate_design_vorlagen/index.de.jsp;
  };
}
