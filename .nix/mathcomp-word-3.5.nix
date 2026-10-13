{ lib, fetchurl }:
old: {
  name = "${lib.removeSuffix old.version old.name}3.5";
  version = "3.5";
  src = fetchurl {
    url = "https://github.com/jasmin-lang/coqword/releases/download/v3.5/coq-mathcomp-word-v3.5.tbz";
    hash = "sha256-ur6XGhTUQ1XdcyC6RERYaTwyzL58mWwdihY/yemjfQg=";
  };
}
