/-
SIDESubstrateCluster.MuClassifier

The Mobius-charge classifier for the dark-sector equation-of-state assignment.
Tests the ELEVEN_TWELFTHS open question: does the basis-independent
(S3-invariant) constraint CLOSE the catalogue of admissible
weight-1 / weight-2 -> {w = -1, w = 0} assignments, and is the Mobius
charge mu = (-1)^weight the classifier?

Built on SIDESubstrateCluster.Substrate. Vanilla Lean 4, no Mathlib,
no sorry, no axioms.
-/

import SIDESubstrateCluster.Substrate

namespace SIDESubstrateCluster

/-- Mobius charge parity: true = odd weight = mu(s) = -1. -/
def Substrate.muOdd (s : Substrate) : Bool := s.weight % 2 == 1

inductive EoS where
  | wNeg1
  | w0
  | resid
  deriving DecidableEq, BEq, Repr

/-- An S3-invariant assignment is a function of weight: a triple
(value on weight-1 class, weight-2 class, weight-3 diagonal). -/
abbrev Assign := Prod EoS (Prod EoS EoS)

def evalA (a : Assign) (s : Substrate) : EoS :=
  match s.weight with
  | 1 => a.1
  | 2 => a.2.1
  | _ => a.2.2

def M1 : Assign := (EoS.wNeg1, EoS.w0, EoS.resid)
def M2 : Assign := (EoS.w0, EoS.wNeg1, EoS.resid)

def isDark (s : Substrate) : Bool := s.weight == 1 || s.weight == 2

def darkSplit (a : Assign) : Bool :=
  ((a.1 == EoS.wNeg1) || (a.1 == EoS.w0)) &&
  ((a.2.1 == EoS.wNeg1) || (a.2.1 == EoS.w0)) &&
  (a.1 != a.2.1)

def decodeEoS (k : Nat) : EoS :=
  match k % 3 with
  | 0 => EoS.wNeg1
  | 1 => EoS.w0
  | _ => EoS.resid

def decodeAssign (n : Nat) : Assign :=
  (decodeEoS (n / 9), decodeEoS (n / 3), decodeEoS n)

def allAssign : List Assign := (List.range 27).map decodeAssign

theorem catalogue_card :
    (allAssign.filter (fun a => darkSplit a && (a.2.2 == EoS.resid))).length = 2 := by
  decide

theorem catalogue_is_doubleton :
    allAssign.filter (fun a => darkSplit a && (a.2.2 == EoS.resid)) = [M1, M2] := by
  decide

theorem M1_tracks_mu :
    Substrate.all.all
      (fun s => !isDark s || ((evalA M1 s == EoS.wNeg1) == s.muOdd)) = true := by
  decide

theorem M2_tracks_neg_mu :
    Substrate.all.all
      (fun s => !isDark s || ((evalA M2 s == EoS.wNeg1) == !s.muOdd)) = true := by
  decide

theorem diagonal_mu_odd : Substrate.b111.muOdd = true := by decide

theorem diagonal_shares_parity_with_DE :
    Substrate.b111.muOdd = Substrate.b100.muOdd := by decide

def Substrate.cyc : Substrate -> Substrate
  | .b100 => .b010
  | .b010 => .b001
  | .b001 => .b100
  | .b110 => .b011
  | .b011 => .b101
  | .b101 => .b110
  | .b111 => .b111

theorem cyc_weight_invariant :
    Substrate.all.all (fun s => s.cyc.weight == s.weight) = true := by decide

theorem cyc_orbit_weight1 :
    [Substrate.b100, Substrate.b100.cyc, Substrate.b100.cyc.cyc]
      = [Substrate.b100, Substrate.b010, Substrate.b001] := by decide

theorem cyc_orbit_weight2 :
    [Substrate.b110, Substrate.b110.cyc, Substrate.b110.cyc.cyc]
      = [Substrate.b110, Substrate.b011, Substrate.b101] := by decide

theorem cyc_fixes_diagonal : Substrate.b111.cyc = Substrate.b111 := by decide

end SIDESubstrateCluster