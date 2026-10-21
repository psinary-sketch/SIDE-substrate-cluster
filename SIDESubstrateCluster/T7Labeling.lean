/-
Copyright (c) 2026 J. York Seale. All rights reserved.
SPDX-License-Identifier: MIT

Authors: J. York Seale (ORCID: 0009-0008-7993-0310)

The PLACE TO STAND Research Programme — SIDE-substrate-cluster kernel
SIDESubstrateCluster/T7Labeling.lean

# 𝕋₇ Labeling of the Substrate

This file establishes the canonical bijection between the substrate
((ℤ/2)³ \ {0}) and the Möbius strips of the Klein-bottle topology
𝕋₇, per klein_trivium.pdf (Seven Möbius Strips on a Fano Frame).

## The labeling

Each Trivium quadratic field K = ℚ(√d) for d ∈ {−1, 2, 3, −2, −3, 6, −6}
gives one strip of klein_trivium.pdf. How a strip is built from the
field's critical strip is that manuscript's own statement, retired here
to the errata and compiled nowhere in this kernel: the map this header
named before, read as written, fixes the critical line pointwise with no
translation, and its quotient of the strip is a half-strip.
The seven strips share the critical line
σ = 1/2 as common boundary.

The strips are labeled by their discriminant d, and the bijection to
substrate uses the same {2, 3, −1} bit-pattern encoding as the Trivium
labeling (TriviumLabeling.lean). The structural distinction: Trivium
discriminants are algebraic objects (quadratic fields); 𝕋₇ strips are
topological objects (Möbius surfaces). The labels coincide; the
underlying mathematical content differs.

## What this file proves

  • Canonical bijection `Substrate.toT7 : Substrate → T7Strip`
  • Inverse `T7Strip.toSubstrate`
  • Bijection identities (left and right inverse)
  • Hamming weight preserved (Test 1 passes)

Vanilla Lean 4. No Mathlib. No sorry. No axioms.
-/

import SIDESubstrateCluster.Substrate

namespace SIDESubstrateCluster

/-! ## The 𝕋₇ Möbius strips -/

/-- The seven Möbius strips of the 𝕋₇ Klein-bottle topology, labeled
by the Trivium discriminant of the underlying quadratic field. -/
inductive T7Strip where
  | mdn1   -- strip from ℚ(i),    discriminant −1
  | md2    -- strip from ℚ(√2),   discriminant  2
  | md3    -- strip from ℚ(√3),   discriminant  3
  | mdn2   -- strip from ℚ(√−2),  discriminant −2
  | mdn3   -- strip from ℚ(√−3),  discriminant −3
  | md6    -- strip from ℚ(√6),   discriminant  6
  | mdn6   -- strip from ℚ(√−6),  discriminant −6
  deriving DecidableEq, Repr

/-- Enumeration of 𝕋₇ strips in canonical (weight-ascending) order. -/
def T7Strip.all : List T7Strip :=
  [.mdn1, .md2, .md3, .mdn2, .mdn3, .md6, .mdn6]

/-- The 𝕋₇ strip cardinality. -/
theorem t7_count : T7Strip.all.length = 7 := by rfl

/-! ## The canonical bijection -/

/-- Canonical map from substrate to 𝕋₇ strips by discriminant bit pattern. -/
def Substrate.toT7 : Substrate → T7Strip
  | .b100 => .mdn1
  | .b010 => .md2
  | .b001 => .md3
  | .b110 => .mdn2
  | .b101 => .mdn3
  | .b011 => .md6
  | .b111 => .mdn6

/-- Canonical inverse. -/
def T7Strip.toSubstrate : T7Strip → Substrate
  | .mdn1 => .b100
  | .md2  => .b010
  | .md3  => .b001
  | .mdn2 => .b110
  | .mdn3 => .b101
  | .md6  => .b011
  | .mdn6 => .b111

/-! ## Bijection theorems -/

theorem substrate_to_t7_left_inv (s : Substrate) :
    s.toT7.toSubstrate = s := by
  cases s <;> rfl

theorem t7_to_substrate_right_inv (m : T7Strip) :
    m.toSubstrate.toT7 = m := by
  cases m <;> rfl

/-! ## Partition preservation (Test 1) -/

/-- Hamming weight on 𝕋₇ strips by discriminant bit pattern. -/
def T7Strip.weight : T7Strip → Nat
  | .mdn1 | .md2 | .md3 => 1
  | .mdn2 | .mdn3 | .md6 => 2
  | .mdn6 => 3

theorem weight_preserved_substrate_to_t7 (s : Substrate) :
    s.toT7.weight = s.weight := by
  cases s <;> rfl

theorem weight_preserved_t7_to_substrate (m : T7Strip) :
    m.toSubstrate.weight = m.weight := by
  cases m <;> rfl

/-- **Test 1 passes for the substrate–𝕋₇ pair.** -/
theorem test_1_substrate_t7 :
    (∀ s : Substrate, s.toT7.weight = s.weight) ∧
    (∀ m : T7Strip, m.toSubstrate.weight = m.weight) :=
  ⟨weight_preserved_substrate_to_t7,
   weight_preserved_t7_to_substrate⟩

end SIDESubstrateCluster
