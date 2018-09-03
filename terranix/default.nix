{ stdenv, pkgs, buildGoPackage, fetchgit }:

let
  nixos-pure-rebuild = stdenv.mkDerivation rec {
    name = "nixos-pure-rebuild";
    version = "0.0.6";
    rev = "3e4eca1491e675f23e01ecd0a91c0fa3a6841a8e";

    src = fetchgit {
      url = https://github.com/andrewchambers/nixos-pure-rebuild.git;
      sha256 = "1dg4va1l1lx05qmkp9k80wxmvc7pp91z9g10yvhk4l9p0sh9z4dh";
    };

    installPhase = ''
      mkdir -p $out/bin
      install -D -m 755 nixos-pure-rebuild.sh $out/bin/nixos-pure-rebuild
    '';
  };
in

buildGoPackage rec {
  name = "terraform-provider-nixos";
  version = "0.0.20170604";
  rev = "e87ac4deebcc9fa231c5c18f7dcea1ca8bfa35f4";

  goPackagePath = "github.com/andrewchambers/terranix";

  src = fetchgit {
    inherit rev;
    url = https://github.com/andrewchambers/terranix.git;
    sha256 = "0ri6hkacfqhwmpc7ihr49c2607sa605mnm4yp1h2x0527j6y7sb7";
  };

  postPatch = ''
    substituteInPlace "nixos/nixos.go" --replace "nixos-pure-rebuild" "${nixos-pure-rebuild}/bin/nixos-pure-rebuild"
  '';

  goDeps = ./deps.nix;
}
