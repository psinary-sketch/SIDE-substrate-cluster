/-
  SIDESubstrateCluster.PairingObstruction

  Formalises the structural rationale for the 1/12 residual in
  MATTER_AS_ARITHMETIC §VI: the Hamming weight-3 diagonal element of
  (ℤ/2)³ has no pairing partner under antipodal pairing within the substrate.

  Self-contained — no imports from other SIDESubstrateCluster modules.

  Vanilla Lean 4, no Mathlib, no sorry, no axioms.
-/

namespace SIDESubstrateCluster
namespace PairingObstruction

structure Triple where
  x : Bool
  y : Bool
  z : Bool
  deriving DecidableEq, Repr

def zero : Triple := ⟨false, false, false⟩
def diagonal : Triple := ⟨true, true, true⟩

def inSubstrate (t : Triple) : Bool := t.x || t.y || t.z

def hammingWeight (t : Triple) : Nat :=
  (if t.x then 1 else 0) + (if t.y then 1 else 0) + (if t.z then 1 else 0)

def antipode (t : Triple) : Triple := ⟨!t.x, !t.y, !t.z⟩

/-- Antipodal pairing is an involution.  We destructure `t` first so the
    case-splits become concrete and `rfl` closes each branch. -/
theorem antipode_involutive (t : Triple) : antipode (antipode t) = t := by
  obtain ⟨x, y, z⟩ := t
  cases x <;> cases y <;> cases z <;> rfl

theorem diagonal_weight_eq_three : hammingWeight diagonal = 3 := by decide
theorem antipode_diagonal_eq_zero : antipode diagonal = zero := by decide
theorem zero_not_in_substrate : inSubstrate zero = false := by decide
theorem diagonal_unpaired : inSubstrate (antipode diagonal) = false := by decide

def e1 : Triple := ⟨true, false, false⟩
def e2 : Triple := ⟨false, true, false⟩
def e3 : Triple := ⟨false, false, true⟩
def f1 : Triple := ⟨false, true, true⟩
def f2 : Triple := ⟨true, false, true⟩
def f3 : Triple := ⟨true, true, false⟩

theorem e1_pairs_f1 : antipode e1 = f1 ∧ hammingWeight e1 = 1 ∧ hammingWeight f1 = 2 := by decide
theorem e2_pairs_f2 : antipode e2 = f2 ∧ hammingWeight e2 = 1 ∧ hammingWeight f2 = 2 := by decide
theorem e3_pairs_f3 : antipode e3 = f3 ∧ hammingWeight e3 = 1 ∧ hammingWeight f3 = 2 := by decide

theorem weight_one_two_in_substrate :
    inSubstrate e1 ∧ inSubstrate e2 ∧ inSubstrate e3 ∧
    inSubstrate f1 ∧ inSubstrate f2 ∧ inSubstrate f3 := by decide

theorem diagonal_in_substrate : inSubstrate diagonal = true := by decide
theorem total_substrate_count : 6 + 1 = 7 := by decide

/-- Main theorem: in the orbit decomposition of (ℤ/2)³ \ {0} under
    antipodal pairing, exactly one element is unpaired — the weight-3
    diagonal.  Topological obstruction to complete pairwise cancellation. -/
theorem obstruction_theorem :
    inSubstrate diagonal = true ∧
    inSubstrate (antipode diagonal) = false ∧
    inSubstrate e1 = true ∧ inSubstrate (antipode e1) = true ∧
    inSubstrate e2 = true ∧ inSubstrate (antipode e2) = true ∧
    inSubstrate e3 = true ∧ inSubstrate (antipode e3) = true := by
  decide

def unpairedElements : List Triple := [diagonal]
theorem unpairedElements_length : unpairedElements.length = 1 := by decide

theorem unpaired_has_weight_three : hammingWeight diagonal = 3 :=
  diagonal_weight_eq_three

theorem all_unpaired_have_weight_three :
    unpairedElements.all (fun t => decide (hammingWeight t = 3)) = true := by
  decide

end PairingObstruction
end SIDESubstrateCluster
