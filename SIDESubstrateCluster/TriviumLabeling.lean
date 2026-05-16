/-
Copyright (c) 2026 J. York Seale. All rights reserved.
SPDX-License-Identifier: MIT

Authors: J. York Seale (ORCID: 0009-0008-7993-0310)

The PLACE TO STAND Research Programme — SIDE-substrate-cluster kernel
SIDESubstrateCluster/TriviumLabeling.lean

# Trivium Labeling of the Substrate

This file establishes the canonical bijection between the substrate
((ℤ/2)³ \ {0}) and the Trivium quadratic discriminants of
TRIVIUM_The_Third_Identity_Element §3 (Proposition 3.2), with the
Hamming-weight partition (3, 3, 1) preserved.

## The labeling

The Trivium generators are {2, 3, −1}. Each discriminant corresponds
to a subset of these generators, read as a binary triple:

  • (1, 0, 0) ↔ −1     ↔ ℚ(i)
  • (0, 1, 0) ↔  2     ↔ ℚ(√2)
  • (0, 0, 1) ↔  3     ↔ ℚ(√3)
  • (1, 1, 0) ↔ −2     ↔ ℚ(√−2)
  • (1, 0, 1) ↔ −3     ↔ ℚ(√−3)
  • (0, 1, 1) ↔  6     ↔ ℚ(√6)
  • (1, 1, 1) ↔ −6     ↔ ℚ(√−6)

The TriviumDisc type is vendored from SIDE-meta v0.3 with attribution
(federation discipline: cross-kernel content is vendored, not imported
via Lake dependencies).

## What this file proves

  • A canonical bijection `Substrate.toTrivium : Substrate → TriviumDisc`
  • Its inverse `TriviumDisc.toSubstrate`
  • The bijection is a left-inverse and right-inverse pair
  • The bijection preserves Hamming weight (Test 1 passes)

## Test 1 in positive direction

This is the case where the structure-preserving bijection synthesis is
structurally justified: substrate and Trivium discriminants share the
same (3, 3, 1) Hamming-weight partition, and the bijection is canonical.
Contrast with the convergent-seven framing in v0.2 SIDE-meta where the
attempted bijection failed Test 1 because the partition structures
differed.

Vanilla Lean 4. No Mathlib. No sorry. No axioms.
-/

import SIDESubstrateCluster.Substrate

namespace SIDESubstrateCluster

/-! ## The Trivium quadratic discriminants -/

/-- The Trivium quadratic discriminants per
TRIVIUM_The_Third_Identity_Element §3 (Proposition 3.2). Vendored from
SIDE-meta v0.3 SIDEMeta.MechanismClasses with attribution. -/
inductive TriviumDisc where
  | dn1   -- discriminant −1: ℚ(i)
  | d2    -- discriminant  2: ℚ(√2)
  | d3    -- discriminant  3: ℚ(√3)
  | dn2   -- discriminant −2: ℚ(√−2)
  | dn3   -- discriminant −3: ℚ(√−3)
  | d6    -- discriminant  6: ℚ(√6)
  | dn6   -- discriminant −6: ℚ(√−6)
  deriving DecidableEq, Repr

/-- Enumeration of Trivium discriminants in canonical (weight-ascending)
order, matching `Substrate.all`. -/
def TriviumDisc.all : List TriviumDisc :=
  [.dn1, .d2, .d3, .dn2, .dn3, .d6, .dn6]

/-- The Trivium discriminant cardinality. -/
theorem trivium_count : TriviumDisc.all.length = 7 := by rfl

/-! ## The canonical bijection -/

/-- Canonical map from substrate to Trivium discriminants, matching
the binary-triple encoding of generators {−1, 2, 3}. -/
def Substrate.toTrivium : Substrate → TriviumDisc
  | .b100 => .dn1
  | .b010 => .d2
  | .b001 => .d3
  | .b110 => .dn2
  | .b101 => .dn3
  | .b011 => .d6
  | .b111 => .dn6

/-- Canonical inverse: Trivium discriminants back to substrate. -/
def TriviumDisc.toSubstrate : TriviumDisc → Substrate
  | .dn1 => .b100
  | .d2  => .b010
  | .d3  => .b001
  | .dn2 => .b110
  | .dn3 => .b101
  | .d6  => .b011
  | .dn6 => .b111

/-! ## Bijection theorems -/

/-- The substrate-to-Trivium map followed by its inverse is the identity
on substrate. -/
theorem substrate_to_trivium_left_inv (s : Substrate) :
    s.toTrivium.toSubstrate = s := by
  cases s <;> rfl

/-- The Trivium-to-substrate map followed by its inverse is the identity
on Trivium discriminants. -/
theorem trivium_to_substrate_right_inv (d : TriviumDisc) :
    d.toSubstrate.toTrivium = d := by
  cases d <;> rfl

/-! ## Partition preservation (Test 1) -/

/-- Hamming weight on Trivium discriminants via the canonical labeling. -/
def TriviumDisc.weight : TriviumDisc → Nat
  | .dn1 | .d2 | .d3 => 1
  | .dn2 | .dn3 | .d6 => 2
  | .dn6 => 3

/-- **Partition preservation (substrate → Trivium).** The bijection
preserves Hamming weight. -/
theorem weight_preserved_substrate_to_trivium (s : Substrate) :
    s.toTrivium.weight = s.weight := by
  cases s <;> rfl

/-- **Partition preservation (Trivium → substrate).** The inverse
bijection preserves Hamming weight. -/
theorem weight_preserved_trivium_to_substrate (d : TriviumDisc) :
    d.toSubstrate.weight = d.weight := by
  cases d <;> rfl

/-- **Test 1 passes for the substrate–Trivium pair.** The bijection
is partition-preserving in both directions, establishing the
structure-preserving bijection between the substrate and the Trivium
discriminants. -/
theorem test_1_substrate_trivium :
    (∀ s : Substrate, s.toTrivium.weight = s.weight) ∧
    (∀ d : TriviumDisc, d.toSubstrate.weight = d.weight) :=
  ⟨weight_preserved_substrate_to_trivium,
   weight_preserved_trivium_to_substrate⟩

end SIDESubstrateCluster
