{
  ## DO NOT CHANGE THIS
  format = "1.0.0";

  attribute = "ssprove";

  no-rocq-yet = true;
  default-bundle = "9.0";

  bundles."9.0" = {
    coqPackages = {
      coq.override.version = "9.0";
      mathcomp.job = false;
      # MathComp >= 2.4.0 is required by the ringType -> nzRingType renaming
      # in the sources; 2.5.0 + analysis 1.16.0 is the newest combination
      # whose released extructures/mathcomp-word are compatible (analysis
      # 1.17.0 requires MathComp 2.6.0, which they do not support yet).
      mathcomp.override.version = "2.5.0";
      mathcomp-analysis.override.version = "1.16.0";
    }; rocqPackages = {
      rocq-core.override.version = "9.0";
    };
    push-branches = ["main" "rocq-9.0"];
  };
  bundles."9.1" = {
    coqPackages = {
      coq.override.version = "9.1";
      mathcomp.job = false;
      mathcomp.override.version = "2.5.0";
      mathcomp-analysis.override.version = "1.16.0";
    }; rocqPackages = {
      rocq-core.override.version = "9.1";
    };
    push-branches = ["main" "rocq-9.1"];
  };
  bundles."MC-dev" = {
    coqPackages = {
      coq.override.version = "9.1";
      mathcomp.job = false;
      mathcomp.override.version = "master";
      mathcomp-analysis.job = false;
      mathcomp-analysis.override.version = "master";
      mathcomp-real-closed.job = false;
      mathcomp-real-closed.override.version = "master";
      mathcomp-finmap.job = false;
      mathcomp-finmap.override.version = "master";
      mathcomp-word.job = false;
      mathcomp-word.override.version = "main";
      extructures.job = false;
      extructures.override.version = "master";
      deriving.job = false;
      deriving.override.version = "master";
      mathcomp-bigenough.job = false;
      mathcomp-bigenough.override.version = "master";
    }; rocqPackages = {
      rocq-core.override.version = "9.1";
      mathcomp.job = false;
      mathcomp.override.version = "master";
      mathcomp-real-closed.job = false;
      mathcomp-real-closed.override.version = "master";
      mathcomp-finmap.job = false;
      mathcomp-finmap.override.version = "master";
      mathcomp-bigenough.job = false;
      mathcomp-bigenough.override.version = "master";
      mathcomp-analysis.job = false;
      mathcomp-analysis.override.version = "master";
    };
  };

  cachix.coq = {};
  cachix.math-comp = {};
  cachix.coq-community = {};
  cachix.ssprove.authToken = "CACHIX_AUTH_TOKEN";
}
