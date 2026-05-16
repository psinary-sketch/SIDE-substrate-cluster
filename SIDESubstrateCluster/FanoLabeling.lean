/-
Copyright (c) 2026 J. York Seale. All rights reserved.
SPDX-License-Identifier: MIT

Authors: J. York Seale (ORCID: 0009-0008-7993-0310)

The PLACE TO STAND Research Programme — SIDE-substrate-cluster kernel
SIDESubstrateCluster/FanoLabeling.lean

# Fano Labeling of the Substrate

This file establishes the canonical bijection between the substrate
((ℤ/2)³ \ {0}) and the points of the Fano plane PG(2, 𝔽₂), per
FANO_PLANE_OF_ARITHMETIC.

## The labeling

Each Fano point [x : y : z] over 𝔽₂ has exactly one nonzero
representative (since 𝔽₂ has no nontrivial scalar multiples). The
seven Fano points are:

  • [1 : 0 : 0], [0 : 1 : 0], [0 : 0 : 1] — weight 1
  • [1 : 1 : 0], [1 : 0 : 1], [0 : 1 : 1] — weight 2
  • [1 : 1 : 1]                            — weight 3

The bijection to substrate identifies each Fano point with the
substrate element having matching bit pattern.

## What this file proves

  • Canonical bijection `Substrate.toFano : Substrate → FanoPoint`
  • Inverse `FanoPoint.toSubstrate`
  • Bijection identities (left and right inverse)
  • Hamming weight preserved (Test 1 passes)

Vanilla Lean 4. No Mathlib. No sorry. No axioms.
-/

import SIDESubstrateCluster.Substrate

namespace SIDESubstrateCluster

/-! ## The Fano plane points -/

/-- Points of the Fano plane PG(2, 𝔽₂), indexed by their unique
nonzero projective representative. -/
inductive FanoPoint where
  | p100  -- [1 : 0 : 0]
  | p010  -- [0 : 1 : 0]
  | p001  -- [0 : 0 : 1]
  | p110  -- [1 : 1 : 0]
  | p101  -- [1 : 0 : 1]
  | p011  -- [0 : 1 : 1]
  | p111  -- [1 : 1 : 1]
  deriving DecidableEq, Repr

/-- Enumeration of Fano points in canonical (weight-ascending) order. -/
def FanoPoint.all : List FanoPoint :=
  [.p100, .p010, .p001, .p110, .p101, .p011, .p111]

/-- The Fano plane point cardinality. -/
theorem fano_count : FanoPoint.all.length = 7 := by rfl

/-! ## The canonical bijection -/

/-- Canonical map from substrate to Fano points by matching bit pattern. -/
def Substrate.toFano : Substrate → FanoPoint
  | .b100 => .p100
  | .b010 => .p010
  | .b001 => .p001
  | .b110 => .p110
  | .b101 => .p101
  | .b011 => .p011
  | .b111 => .p111

/-- Canonical inverse. -/
def FanoPoint.toSubstrate : FanoPoint → Substrate
  | .p100 => .b100
  | .p010 => .b010
  | .p001 => .b001
  | .p110 => .b110
  | .p101 => .b101
  | .p011 => .b011
  | .p111 => .b111

/-! ## Bijection theorems -/

theorem substrate_to_fano_left_inv (s : Substrate) :
    s.toFano.toSubstrate = s := by
  cases s <;> rfl

theorem fano_to_substrate_right_inv (f : FanoPoint) :
    f.toSubstrate.toFano = f := by
  cases f <;> rfl

/-! ## Partition preservation (Test 1) -/

/-- Hamming weight on Fano points by projective bit pattern. -/
def FanoPoint.weight : FanoPoint → Nat
  | .p100 | .p010 | .p001 => 1
  | .p110 | .p101 | .p011 => 2
  | .p111 => 3

theorem weight_preserved_substrate_to_fano (s : Substrate) :
    s.toFano.weight = s.weight := by
  cases s <;> rfl

theorem weight_preserved_fano_to_substrate (f : FanoPoint) :
    f.toSubstrate.weight = f.weight := by
  cases f <;> rfl

/-- **Test 1 passes for the substrate–Fano pair.** -/
theorem test_1_substrate_fano :
    (∀ s : Substrate, s.toFano.weight = s.weight) ∧
    (∀ f : FanoPoint, f.toSubstrate.weight = f.weight) :=
  ⟨weight_preserved_substrate_to_fano,
   weight_preserved_fano_to_substrate⟩

end SIDESubstrateCluster
