Set Warnings "-ambiguous-paths,-notation-overridden,-notation-incompatible-format".
From mathcomp Require Import all_ssreflect.
Set Warnings "ambiguous-paths,notation-overridden,notation-incompatible-format".
From extructures Require Import ord fset fmap.
From SSProve.Crypt Require Import NominalPrelude.

Import PackageNotation.
Local Open Scope package_scope.

Definition named_interface : Interface :=
  [interface [0] : { chNat ~> chNat }].

Definition tuple_interface : Interface :=
  [interface [0] : { chProd chNat chNat ~> chNat }].

Definition named_reference : package [interface] named_interface :=
  [package emptym ;
    [0] : { chNat ~> chNat } (x) {
      ret (addn x 0)
    }
  ].

Definition named_typed : package [interface] named_interface :=
  [package emptym ;
    [0] : { chNat ~> chNat } (x) {
      ret (addn x 0)
    }
  ].

Definition named_inferred : package [interface] named_interface :=
  [package emptym ;
    [0] (x) {
      ret (addn x 0)
    }
  ].

Definition tuple_reference : package [interface] tuple_interface :=
  [package emptym ;
    [0] : { chProd chNat chNat ~> chNat } '(x, y) {
      ret (addn x y)
    }
  ].

Definition tuple_typed : package [interface] tuple_interface :=
  [package emptym ;
    [0] : { chProd chNat chNat ~> chNat } '(x, y) {
      ret (addn x y)
    }
  ].

Definition tuple_inferred : package [interface] tuple_interface :=
  [package emptym ;
    [0] '(x, y) {
      ret (addn x y)
    }
  ].

Example named_typedE : pack named_typed = pack named_reference.
Proof. reflexivity. Qed.

Example named_inferredE : pack named_inferred = pack named_reference.
Proof. reflexivity. Qed.

Example tuple_typedE : pack tuple_typed = pack tuple_reference.
Proof. reflexivity. Qed.

Example tuple_inferredE : pack tuple_inferred = pack tuple_reference.
Proof. reflexivity. Qed.
