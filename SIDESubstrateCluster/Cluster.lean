/-
Copyright (c) 2026 J. York Seale. All rights reserved.
SPDX-License-Identifier: MIT

Authors: J. York Seale (ORCID: 0009-0008-7993-0310)

The PLACE TO STAND Research Programme — SIDE-substrate-cluster kernel
SIDESubstrateCluster/Cluster.lean

# The {2,3}-Substrate Cluster — Four-Way Bijection Family

This file states the cluster theorem: the substrate ((ℤ/2)³ \ {0})
admits canonical partition-preserving bijections to four contexts —
Trivium quadratic discriminants, Fano plane points, Steane code basis
qubits, and 𝕋₇ Klein-bottle Möbius strips. All four labelings share
the Hamming-weight (3, 3, 1) partition.

## What this file proves

A single packaged theorem `cluster_bijection_family` asserting that
Test 1 passes for all four pairwise bijections (substrate to each of
Trivium / Fano / Steane / 𝕋₇).

The pairwise component theorems are in the companion files:
  • `TriviumLabeling.lean` — substrate ↔ Trivium discriminants
  • `FanoLabeling.lean`    — substrate ↔ Fano points
  • `SteaneLabeling.lean`  — substrate ↔ Steane qubits
  • `T7Labeling.lean`      — substrate ↔ 𝕋₇ strips

Through composition, any two of the four contexts are also in
canonical partition-preserving bijection. The cluster theorem
packages the full family.

Vanilla Lean 4. No Mathlib. No sorry. No axioms.
-/

import SIDESubstrateCluster.Substrate
import SIDESubstrateCluster.TriviumLabeling
import SIDESubstrateCluster.FanoLabeling
import SIDESubstrateCluster.SteaneLabeling
import SIDESubstrateCluster.T7Labeling

namespace SIDESubstrateCluster

/-- **Cluster Bijection Family Theorem.**  The substrate admits
canonical Hamming-weight-preserving bijections to all four contexts
of the {2,3}-cluster: Trivium discriminants, Fano points, Steane
qubits, and 𝕋₇ Möbius strips.  All four are realizations of the same
underlying (ℤ/2)³ \ {0} structure with the (3, 3, 1) weight partition. -/
theorem cluster_bijection_family :
    (∀ s : Substrate, s.toTrivium.weight  = s.weight) ∧
    (∀ s : Substrate, s.toFano.weight     = s.weight) ∧
    (∀ s : Substrate, s.toSteane.columnWeight = s.weight) ∧
    (∀ s : Substrate, s.toT7.weight       = s.weight) :=
  ⟨weight_preserved_substrate_to_trivium,
   weight_preserved_substrate_to_fano,
   weight_preserved_substrate_to_steane,
   weight_preserved_substrate_to_t7⟩

/-! ## Pairwise compositions

Bijections between any pair of the four contexts can be constructed by
composing through substrate.  For example, Trivium ↔ Fano via
`d.toSubstrate.toFano` and `f.toSubstrate.toTrivium`.  The
partition-preservation property is preserved under composition. -/

/-- Direct bijection Trivium ↔ Fano via substrate. -/
def TriviumDisc.toFano (d : TriviumDisc) : FanoPoint :=
  d.toSubstrate.toFano

/-- Direct bijection Fano ↔ Trivium via substrate. -/
def FanoPoint.toTrivium (f : FanoPoint) : TriviumDisc :=
  f.toSubstrate.toTrivium

theorem trivium_to_fano_left_inv (d : TriviumDisc) :
    d.toFano.toTrivium = d := by
  cases d <;> rfl

theorem fano_to_trivium_right_inv (f : FanoPoint) :
    f.toTrivium.toFano = f := by
  cases f <;> rfl

/-- Direct bijection Steane ↔ 𝕋₇ via substrate. -/
def SteaneQubit.toT7 (q : SteaneQubit) : T7Strip :=
  q.toSubstrate.toT7

def T7Strip.toSteane (m : T7Strip) : SteaneQubit :=
  m.toSubstrate.toSteane

theorem steane_to_t7_left_inv (q : SteaneQubit) :
    q.toT7.toSteane = q := by
  cases q <;> rfl

theorem t7_to_steane_right_inv (m : T7Strip) :
    m.toSteane.toT7 = m := by
  cases m <;> rfl

end SIDESubstrateCluster
