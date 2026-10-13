{
  lib,
  fetchurl,
  coq,
  mkCoqDerivation,
  mathcomp,
  stdlib,
  version ? null,
}:
let
  upstreamWord = import ((import ../../nixpkgs.nix) + "/pkgs/development/coq-modules/mathcomp-word/default.nix") {
    inherit lib fetchurl coq mkCoqDerivation mathcomp stdlib;
    version = if version == "3.5" then null else version;
  };
in
if version == null || version == "3.5" then
  upstreamWord.overrideAttrs (import ../../mathcomp-word-3.5.nix {
    inherit lib fetchurl;
  })
else
  upstreamWord
