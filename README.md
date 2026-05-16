# SIDE-substrate-cluster (v0.2)

**The PLACE TO STAND Research Programme — Substrate Cluster Kernel**

J. York Seale (ORCID: 0009-0008-7993-0310)

## Purpose

This kernel formalizes the {2,3}-substrate — the nontrivial elements
of (ℤ/2)³ — and its four canonical realizations in the PLACE TO STAND
corpus, with the Hamming-weight partition (3, 3, 1) preserved across
all four labelings.

## The four canonical labelings

| Labeling | Context | Source |
|---|---|---|
| **Trivium** | Quadratic discriminants from generators {2, 3, −1} | TRIVIUM_The_Third_Identity_Element §3 |
| **Fano** | Points of PG(2, 𝔽₂) | FANO_PLANE_OF_ARITHMETIC |
| **Steane** | Physical qubits of the [[7, 1, 3]] Steane code | ARITHMETIC_ORIGIN_STEANE_CODE_v3 |
| **𝕋₇** | Möbius strips of the Klein-bottle topology | klein_trivium.pdf |

Each is a canonical realization of the same (ℤ/2)³ \ {0} substrate.
Pairwise bijections between any two labelings exist via composition
through substrate, and all are partition-preserving.

Canonical Lean citations:
- `SIDESubstrateCluster.cluster_bijection_family` — the packaged
  four-way Test 1 theorem
- `SIDESubstrateCluster.partition_cardinalities` — the (3, 3, 1)
  partition
- Per-pair Test 1 theorems: `test_1_substrate_trivium`,
  `test_1_substrate_fano`, `test_1_substrate_steane`,
  `test_1_substrate_t7`

## What this kernel proves

Substrate-level:
- `substrate_count` — substrate is a 7-element type
- `partition_weight_one / two / three` — explicit (3, 3, 1) partition
- `partition_cardinalities` — partition cardinalities theorem

Per-labeling level (for each of Trivium, Fano, Steane, 𝕋₇):
- Cardinality theorem
- Forward bijection function (`Substrate.toX`)
- Inverse bijection function (`X.toSubstrate`)
- Left-inverse and right-inverse theorems
- Weight function on the labeled type
- Partition-preservation theorems (both directions)
- Per-pair `test_1_substrate_X` theorem

Cluster-level:
- `cluster_bijection_family` — the four-way Test 1 packaged
- Selected pairwise direct bijections (Trivium ↔ Fano, Steane ↔ 𝕋₇)

All vanilla Lean 4, no Mathlib, no `sorry`, no axioms.

## Federation discipline

This kernel sits alongside the other PLACE TO STAND kernels:

- `SIDE-kernel`              — RH proof core (Day 1 deposit)
- `SIDE-trivium`             — Trivium-specific machinery
- `SIDE-effects`             — framework consequences
- `SIDE-interfaces`          — interface boundaries
- `SIDE-meta v0.3`           — parametric SIDESystem template,
                               MechanismClass (CATALOGOS canonical),
                               κ predicate
- `SIDE-bijection v0.1`      — corpus-level Identity-Formation
                               Bijection theorem
- `SIDE-omega-b v0.1`        — Ω_b = 4/81 final arithmetic
- **`SIDE-substrate-cluster v0.2`** — *this kernel*: substrate +
                                      four canonical labelings +
                                      four-way bijection family

Each kernel is independently auditable, pins its own toolchain
(`leanprover/lean4:v4.29.0-rc8`), and has its own git history.
Cross-kernel content is vendored with attribution.

## Versions

- **v0.1** — Substrate + Trivium labeling
- **v0.2** *(this version)* — adds Fano, Steane, 𝕋₇ labelings and the
  packaged cluster-bijection-family theorem

## Build

```
lake build
```

No external dependencies; no Mathlib clone needed.

## License

MIT.
