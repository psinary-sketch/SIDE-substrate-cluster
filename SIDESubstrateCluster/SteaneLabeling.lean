/-
Copyright (c) 2026 J. York Seale. All rights reserved.
SPDX-License-Identifier: MIT

Authors: J. York Seale (ORCID: 0009-0008-7993-0310)

The PLACE TO STAND Research Programme — SIDE-substrate-cluster kernel
SIDESubstrateCluster/SteaneLabeling.lean

# Steane Labeling of the Substrate

This file establishes the canonical bijection between the substrate
((ℤ/2)³ \ {0}) and the physical qubits of the Steane code [[7, 1, 3]],
per ARITHMETIC_ORIGIN_STEANE_CODE_v3 and FANO_PLANE_OF_ARITHMETIC.

## The labeling

The Steane code [[7, 1, 3]] is a quantum CSS code built from the
classical [7, 4, 3] Hamming code. The parity-check matrix of the
Hamming code has seven columns, each a nonzero element of (𝔽₂)³.
Each physical qubit of the Steane code corresponds to one column.

The qubits are indexed q1 through q7, with the bijection to substrate
established by matching each qubit to the substrate element whose
bit pattern matches the qubit's column position in the parity-check
matrix.

## Column weight

The Hamming weight of a substrate element equals the column weight in
the parity-check matrix — the number of stabilizer generators that
act nontrivially on the corresponding qubit. This is the
partition-preserving correspondence (Test 1) between substrate and
Steane qubits.

## What this file proves

  • Canonical bijection `Substrate.toSteane : Substrate → SteaneQubit`
  • Inverse `SteaneQubit.toSubstrate`
  • Bijection identities (left and right inverse)
  • Column weight matches Hamming weight (Test 1 passes)

Vanilla Lean 4. No Mathlib. No sorry. No axioms.
-/

import SIDESubstrateCluster.Substrate

namespace SIDESubstrateCluster

/-! ## The Steane code physical qubits -/

/-- The seven physical qubits of the Steane code [[7, 1, 3]], indexed
by their canonical position in the Hamming parity-check matrix
(canonical-order convention: qi corresponds to substrate position i). -/
inductive SteaneQubit where
  | q1  -- column [1, 0, 0] — column weight 1
  | q2  -- column [0, 1, 0] — column weight 1
  | q3  -- column [0, 0, 1] — column weight 1
  | q4  -- column [1, 1, 0] — column weight 2
  | q5  -- column [1, 0, 1] — column weight 2
  | q6  -- column [0, 1, 1] — column weight 2
  | q7  -- column [1, 1, 1] — column weight 3
  deriving DecidableEq, Repr

/-- Enumeration of Steane qubits in canonical order. -/
def SteaneQubit.all : List SteaneQubit :=
  [.q1, .q2, .q3, .q4, .q5, .q6, .q7]

/-- The Steane qubit cardinality. -/
theorem steane_count : SteaneQubit.all.length = 7 := by rfl

/-! ## The canonical bijection -/

/-- Canonical map from substrate to Steane qubits by column position. -/
def Substrate.toSteane : Substrate → SteaneQubit
  | .b100 => .q1
  | .b010 => .q2
  | .b001 => .q3
  | .b110 => .q4
  | .b101 => .q5
  | .b011 => .q6
  | .b111 => .q7

/-- Canonical inverse. -/
def SteaneQubit.toSubstrate : SteaneQubit → Substrate
  | .q1 => .b100
  | .q2 => .b010
  | .q3 => .b001
  | .q4 => .b110
  | .q5 => .b101
  | .q6 => .b011
  | .q7 => .b111

/-! ## Bijection theorems -/

theorem substrate_to_steane_left_inv (s : Substrate) :
    s.toSteane.toSubstrate = s := by
  cases s <;> rfl

theorem steane_to_substrate_right_inv (q : SteaneQubit) :
    q.toSubstrate.toSteane = q := by
  cases q <;> rfl

/-! ## Partition preservation (Test 1) -/

/-- Column weight of a Steane qubit in the parity-check matrix —
equivalently, the number of stabilizer generators acting nontrivially
on the qubit. -/
def SteaneQubit.columnWeight : SteaneQubit → Nat
  | .q1 | .q2 | .q3 => 1
  | .q4 | .q5 | .q6 => 2
  | .q7 => 3

theorem weight_preserved_substrate_to_steane (s : Substrate) :
    s.toSteane.columnWeight = s.weight := by
  cases s <;> rfl

theorem weight_preserved_steane_to_substrate (q : SteaneQubit) :
    q.toSubstrate.weight = q.columnWeight := by
  cases q <;> rfl

/-- **Test 1 passes for the substrate–Steane pair.** -/
theorem test_1_substrate_steane :
    (∀ s : Substrate, s.toSteane.columnWeight = s.weight) ∧
    (∀ q : SteaneQubit, q.toSubstrate.weight = q.columnWeight) :=
  ⟨weight_preserved_substrate_to_steane,
   weight_preserved_steane_to_substrate⟩

end SIDESubstrateCluster
