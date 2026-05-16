# SIDE-substrate-cluster

**The PLACE TO STAND Research Programme — Substrate Cluster Kernel**

J. York Seale (ORCID: 0009-0008-7993-0310)

## Purpose

This kernel formalizes the {2,3}-substrate — the nontrivial elements
of (ℤ/2)³ — and its canonical Trivium labeling, with the
Hamming-weight partition (3, 3, 1) preserved by the bijection.

This is the **positive case** of Test 1 (structure-preserving
bijection): substrate and Trivium discriminants share the canonical
(3, 3, 1) Hamming-weight partition, and the bijection is
canonical. Test 1 passes.

Canonical Lean citations:
- `SIDESubstrateCluster.test_1_substrate_trivium`
- `SIDESubstrateCluster.partition_cardinalities`
- `SIDESubstrateCluster.substrate_to_trivium_left_inv`
- `SIDESubstrateCluster.trivium_to_substrate_right_inv`

## Why this kernel matters

Four contexts in the corpus realize (ℤ/2)³ \ {0} canonically:

- Trivium quadratic discriminants from generators {2, 3, −1}
  (TRIVIUM_The_Third_Identity_Element §3, FANO_PLANE_OF_ARITHMETIC)
- Fano plane PG(2, 𝔽₂) points
  (FANO_PLANE_OF_ARITHMETIC, phase2_fano_plane.pdf)
- Steane code [[7, 1, 3]] basis qubits via Hamming [7, 4, 3] coordinate
  matrix (ARITHMETIC_ORIGIN_STEANE_CODE_v3)
- 𝕋₇ Klein-bottle topology Möbius strips
  (CORPUS_CATALOGOS §C.3, klein_trivium.pdf)

Each is a canonical labeling of the same underlying substrate. This
v0.1 kernel formalizes the substrate and one canonical labeling
(Trivium discriminants). Future kernel versions or companion kernels
may formalize Fano / Steane / 𝕋₇ labelings analogously.

## Contrast with retracted convergent-seven framing

v0.2 of the SIDE-meta kernel contained a `ConvergentSeven.lean` file
asserting a five-way structural collapse including a bijection
between mechanism classes and Trivium discriminants. That bijection
**failed Test 1** because the partition structures differ:

- Mechanism classes: partition (2, 3, 2) by formation stage
- Trivium discriminants: partition (3, 3, 1) by Hamming weight

Per FORMATION_UNIVERSALITY_v3 §216: no partition of (ℤ/2)³ \ {0}
yields (2, 3, 2). The mechanism-class–Trivium-discriminant bijection
in v0.2 was wrong by partition mismatch.

This v0.1 kernel formalizes the bijection where Test 1 **passes**:
substrate ↔ Trivium, with shared (3, 3, 1) partition. The discipline:
build bijections where Test 1 passes; retract bijections where Test 1
fails. Both directions are now established in the federation.

## Federation discipline

This kernel sits alongside the other PLACE TO STAND kernels:

- `SIDE-kernel`              — RH proof core (Day 1 deposit, public)
- `SIDE-trivium`             — Trivium-specific machinery
- `SIDE-effects`             — framework consequences
- `SIDE-interfaces`          — interface boundaries
- `SIDE-meta v0.3`           — parametric SIDESystem template,
                               MechanismClass (CATALOGOS canonical),
                               κ predicate
- `SIDE-bijection v0.1`      — corpus-level Identity-Formation
                               Bijection theorem
- `SIDE-omega-b v0.1`        — Ω_b = 4/81 final arithmetic
- **`SIDE-substrate-cluster v0.1`** — *this kernel*: {2,3}-substrate
                                      + Trivium labeling + Test 1 pass

Each kernel is independently auditable, pins its own toolchain
(`leanprover/lean4:v4.29.0-rc8`), and has its own git history.
Cross-kernel content is vendored with attribution
(TriviumDisc is vendored from SIDE-meta v0.3).

## What this kernel proves

Substrate-level:
- `substrate_count` — Substrate is enumerated as a 7-element type
- `partition_weight_one`, `partition_weight_two`, `partition_weight_three`
  — explicit (3, 3, 1) partition by Hamming weight
- `partition_cardinalities` — partition cardinalities (3, 3, 1)

Bijection-level:
- `substrate_to_trivium_left_inv` — left-inverse property
- `trivium_to_substrate_right_inv` — right-inverse property

Partition-preservation level:
- `weight_preserved_substrate_to_trivium` — substrate → Trivium preserves weight
- `weight_preserved_trivium_to_substrate` — Trivium → substrate preserves weight
- `test_1_substrate_trivium` — Test 1 passes (both directions
  partition-preserving)

All vanilla Lean 4, no Mathlib, no `sorry`, no axioms.

## What this kernel does NOT formalize (deferred to future kernels)

- **Fano-plane labeling** — the Fano points PG(2, 𝔽₂) as canonical
  labeling of substrate; FANO_PLANE_OF_ARITHMETIC documents this
- **Steane-code labeling** — the [[7, 1, 3]] Steane code basis as
  canonical labeling via Hamming coordinate matrix;
  ARITHMETIC_ORIGIN_STEANE_CODE_v3 documents this
- **𝕋₇ labeling** — the seven Möbius strips of the Klein-bottle
  topology; CORPUS_CATALOGOS §C.3 documents this
- **Full four-way bijection family** — the composition of three more
  labelings into a bijection family with universal partition-preservation

These are bounded follow-on work, each addable as a companion module
(or separate kernel) using the same pattern as TriviumLabeling.

## Build

```
lake build
```

No external dependencies; no Mathlib clone needed.

## License

MIT.
