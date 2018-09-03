{ stdenv, pkgs, python3Packages, ... }:

let
  pname = "bundlewrap";
  version = "3.5.1";
in

python3Packages.buildPythonApplication {
  inherit pname version;

  src = python3Packages.fetchPypi {
    inherit pname version;
    sha256 = "1pa1b1pq0vapqbqp2z2c8xj12ja0zadz57ckyv3lczq3liclpczr";
};

  buildInputs = with python3Packages; [
    setuptools
  ];

  propagatedBuildInputs = with pkgs; [
    python3Packages.cryptography
    python3Packages.jinja2
    python3Packages.Mako
    python3Packages.passlib
    python3Packages.pyyaml
    python3Packages.requests
    python3Packages.six
  ];
}
