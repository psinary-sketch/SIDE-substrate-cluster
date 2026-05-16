/-
Copyright (c) 2026 J. York Seale. All rights reserved.
SPDX-License-Identifier: MIT

Authors: J. York Seale (ORCID: 0009-0008-7993-0310)

The PLACE TO STAND Research Programme — SIDE-substrate-cluster kernel
SIDESubstrateCluster/Substrate.lean

# The {2,3}-Substrate

This file formalizes the substrate underlying the {2,3}-cluster:
the nontrivial elements of (ℤ/2)³, with the canonical Hamming-weight
partition (3, 3, 1).

## What's enumerated

`Substrate` — the nontrivial elements of (ℤ/2)³, indexed by their
binary representation:

  • b100, b010, b001 (weight 1)
  • b110, b101, b011 (weight 2)
  • b111             (weight 3)

## Why this substrate matters

Per the corpus, four contexts realize (ℤ/2)³ \ {0} canonically:

  • Trivium quadratic discriminants from generators {2, 3, −1}
    (TRIVIUM_The_Third_Identity_Element §3, FANO_PLANE_OF_ARITHMETIC)
  • Fano plane PG(2, 𝔽₂) points
    (FANO_PLANE_OF_ARITHMETIC, phase2_fano_plane.pdf)
  • Steane code [[7, 1, 3]] basis qubits via Hamming [7, 4, 3]
    coordinate matrix (ARITHMETIC_ORIGIN_STEANE_CODE_v3)
  • 𝕋₇ Klein-bottle topology Möbius strips
    (CORPUS_CATALOGOS §C.3, klein_trivium.pdf)

Each of these realizations is a canonical labeling of the same
underlying substrate. The partition by Hamming weight (3, 3, 1)
lifts to a partition-preserving bijection across the four contexts
— passing Test 1 (structure-preserving bijection) in all six pairwise
directions.

This kernel formalizes the substrate and its partition. Canonical
labelings (one per context) are formalized in companion modules; the
present module is the substrate-level theorem.

## What this file proves

  • Substrate is enumerated as a 7-element type
  • Hamming weight is computable on each element
  • The partition by weight has cardinalities (3, 3, 1)

## Relation to retracted convergent-seven framing

The v0.2 SIDE-meta convergent-seven synthesis claimed a five-way
collapse of equi-cardinal sets including the mechanism classes of
ξ(s). That synthesis was wrong: the mechanism-class set has
partition (2, 3, 2) by formation stage, which does not match
(3, 3, 1) — the §216 obstruction. The substrate-cluster (this
kernel's subject) is the structural family that DOES collapse
canonically. Test 1 passes for the substrate cluster precisely
because partition matches; Test 1 failed for the mechanism classes
precisely because partition does not match. The discipline:
substrate-cluster work is the positive case where the bijection
synthesis was structurally justified; convergent-seven was the
overreach.

Vanilla Lean 4. No Mathlib. No sorry. No axioms.
-/

namespace SIDESubstrateCluster

/-! ## The substrate -/

/-- The seven nontrivial elements of (ℤ/2)³, indexed by their binary
representation (where bXYZ encodes the bit pattern (X, Y, Z)).

This is the underlying substrate for the {2,3}-cluster. Each canonical
labeling (Trivium / Fano / Steane / 𝕋₇) realizes this substrate. -/
inductive Substrate where
  | b100  -- (1, 0, 0) — weight 1
  | b010  -- (0, 1, 0) — weight 1
  | b001  -- (0, 0, 1) — weight 1
  | b110  -- (1, 1, 0) — weight 2
  | b101  -- (1, 0, 1) — weight 2
  | b011  -- (0, 1, 1) — weight 2
  | b111  -- (1, 1, 1) — weight 3
  deriving DecidableEq, Repr

/-- Enumeration of substrate elements in canonical (weight-ascending) order. -/
def Substrate.all : List Substrate :=
  [.b100, .b010, .b001, .b110, .b101, .b011, .b111]

/-- The substrate cardinality. -/
theorem substrate_count : Substrate.all.length = 7 := by rfl

/-! ## Hamming weight -/

/-- Hamming weight of a substrate element — the number of 1-bits in
its binary representation. -/
def Substrate.weight : Substrate → Nat
  | .b100 | .b010 | .b001 => 1
  | .b110 | .b101 | .b011 => 2
  | .b111 => 3

/-- The substrate elements of a given Hamming weight. -/
def Substrate.weightClass (w : Nat) : List Substrate :=
  Substrate.all.filter (fun s => decide (s.weight = w))

/-! ## The (3, 3, 1) partition -/

/-- The weight-1 substrate elements: standard basis vectors. -/
theorem partition_weight_one :
    Substrate.weightClass 1 = [.b100, .b010, .b001] := by rfl

/-- The weight-2 substrate elements: pairwise sums of basis vectors. -/
theorem partition_weight_two :
    Substrate.weightClass 2 = [.b110, .b101, .b011] := by rfl

/-- The weight-3 substrate element: full sum. -/
theorem partition_weight_three :
    Substrate.weightClass 3 = [.b111] := by rfl

/-- The Hamming-weight partition has cardinalities (3, 3, 1). -/
theorem partition_cardinalities :
    (Substrate.weightClass 1).length = 3 ∧
    (Substrate.weightClass 2).length = 3 ∧
    (Substrate.weightClass 3).length = 1 := by
  refine ⟨?_, ?_, ?_⟩ <;> rfl

end SIDESubstrateCluster
