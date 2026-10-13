(lang dune 3.21)
(using coq 0.11)
(name rocq-ssprove)
(version 0.3.1+remix.1)

(generate_opam_files false)

(source (github SSProve/ssprove))
(license MIT)
(authors "SSProve team")
(maintainers "philipp@haselwarter.org")

(package
 (name rocq-ssprove)
 (synopsis "A Foundational Framework for Modular Cryptographic Proofs")
 (depends (rocq-core (and (>= 9.0) (< 9.2~)))
   (rocq-stdlib (and (>= 9.0) (< 9.2~)))
   (rocq-equations (>= 1.3.1+9.0))
   (coq-mathcomp-ssreflect (and (>= 2.5.0) (< 2.6~)))
   (coq-mathcomp-analysis (>= 1.16.0))
   (coq-mathcomp-experimental-reals (>= 1.16.0))
   (coq-mathcomp-word (and (>= 3.5) (< 3.6~)))
   (coq-extructures (and (>= 0.5.0) (< dev)))
   (coq-deriving (and (>= 0.2.3) (< dev))))
)

(warnings (deprecated_coq_lang disabled))
