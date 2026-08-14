(** * Scope and flag hygiene for files that mix SSProve with another stack

    Rocq replays [Delimit Scope] on every [Import], so which scope a
    delimiter such as [%Z] or [%N] denotes in your file is decided by the
    library you imported *last*, not by the one you meant.  As long as a file
    only imports SSProve and MathComp this is invisible; it stops being
    invisible as soon as a second large stack -- VST/CompCert is the case this
    module was written for -- is loaded next to them.  The observed failure
    modes are [%Z] resolving to MathComp's [int_scope], where a hexadecimal
    constant elaborates as a unary [Posz] literal, and [%N] resolving to
    stdlib's [N_scope] instead of MathComp's [nat_scope], where the two
    disagree silently rather than by a type error.

    USE: [From SSProve.Crypt Require Import Compat.] as the *last* import of
    such a file, below all your other [Require]s -- the point is to be the
    last writer.  Everything here is idempotent.  It re-pins delimiters and
    does not [Open] any scope, so the scope stack itself is left alone.

    This module deliberately depends on nothing outside SSProve and MathComp.
    The coexistence rules that do involve the other stack cannot be enforced
    from here and are stated as review rules at the bottom of this file. *)

Set Warnings "-ambiguous-paths,-notation-overridden,-notation-incompatible-format".
From mathcomp Require Export all_boot all_order all_algebra word_ssrZ word.
From SSProve.Crypt Require Export jasmin_word jasmin_wsize.
Set Warnings "ambiguous-paths,notation-overridden,notation-incompatible-format".

(* The three delimiters that mixed-library files get wrong.  They are re-pinned
   rather than assumed, because [Delimit Scope] is replayed on [Import] and the
   last importer wins. *)
Delimit Scope Z_scope   with Z.     (* stdlib Z, not MathComp int   *)
Delimit Scope nat_scope with N.     (* MathComp nat, not stdlib N   *)
Delimit Scope N_scope   with num.   (* stdlib N still reachable     *)

(** ** Rules this module cannot enforce -- assert them in review

    - Write [%nat], never [%N].  [%N] is contested -- ssrnat delimits
      [nat_scope] with it and stdlib delimits [N_scope] with it -- so it is
      only ever as good as the re-pin above.  [%nat] is stdlib's own
      delimiter for [nat_scope] and nothing else claims it.

    - Get [Z] from [From Stdlib Require Import BinInt], never from bare
      [ZArith]: [ZArith] shadows [^] on [nat] with [Nat.pow].

    - On SSProve releases that predate the [Nominal.v] [SetoidClass] fix, a
      bare [x == y] anywhere below the nominal stack is stdlib's Prop-valued
      [equiv], not MathComp's boolean [eq_op].  Write [(x == y)%B] (opening
      [bool_scope] does not win it back), or [eq_op x y].

    - A carrier that goes into a dependent telescope of a monomorphic
      inductive -- a VST funspec [WITH] telescope is the case at hand, whose
      carrier is embedded through [rmaps.ConstType] at a fixed universe --
      must be universe-small.  Use [wcarrier sz] (in [jasmin_word]), the raw
      record behind [word sz], never the HB-packed [word sz]: the packed
      carrier lives in MathComp's shared structure universe and produces a
      universe inconsistency against any development that has loaded
      [deriving].

    - Twin definitions kept in two files must elaborate their numerals under
      the same scope stack, or they are propositionally but not definitionally
      equal.  Reopen the intended scope by name ([Open Scope Z_scope]) around
      the section that states them, rather than relying on the ambient one. *)
