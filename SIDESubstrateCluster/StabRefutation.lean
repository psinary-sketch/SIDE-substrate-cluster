-- Refutes the ELEVEN_TWELFTHS-flagged false claims (FANO/MATTER group-theory):
--   (a) "stabilizer of the diagonal is S3, order 6"        -> actual order 24
--   (b) "(3,3,1) from the GL(3,F2) parabolic stabilizer"   -> actual orbits {1,6}
-- Vanilla Lean 4, no Mathlib, decide-only (0 sorry, 0 axioms).
set_option maxHeartbeats 4000000
set_option maxRecDepth 4000

namespace SIDESubstrateCluster
namespace StabRefutation

structure Mat where
  a11 : Bool
  a12 : Bool
  a13 : Bool
  a21 : Bool
  a22 : Bool
  a23 : Bool
  a31 : Bool
  a32 : Bool
  a33 : Bool
deriving Repr

abbrev Vec := Prod Bool (Prod Bool Bool)

def bxor (a b : Bool) : Bool := Bool.xor a b

def bit (n k : Nat) : Bool := (n / 2 ^ k) % 2 == 1

def decode (n : Nat) : Mat :=
  { a11 := bit n 0, a12 := bit n 1, a13 := bit n 2,
    a21 := bit n 3, a22 := bit n 4, a23 := bit n 5,
    a31 := bit n 6, a32 := bit n 7, a33 := bit n 8 }

def allMats : List Mat := (List.range 512).map decode

def det (M : Mat) : Bool :=
  bxor (bxor (bxor (bxor (bxor
    (M.a11 && M.a22 && M.a33)
    (M.a12 && M.a23 && M.a31))
    (M.a13 && M.a21 && M.a32))
    (M.a13 && M.a22 && M.a31))
    (M.a11 && M.a23 && M.a32))
    (M.a12 && M.a21 && M.a33)

def act (M : Mat) (v : Vec) : Vec :=
  let (x, y, z) := v
  (bxor (bxor (M.a11 && x) (M.a12 && y)) (M.a13 && z),
   bxor (bxor (M.a21 && x) (M.a22 && y)) (M.a23 && z),
   bxor (bxor (M.a31 && x) (M.a32 && y)) (M.a33 && z))

def GL : List Mat := allMats.filter (fun M => det M)

def diag : Vec := (true, true, true)

def Stab : List Mat := GL.filter (fun M => act M diag == diag)

def sixNonDiag : List Vec :=
  [(true, false, false), (false, true, false), (false, false, true),
   (true, true, false), (true, false, true), (false, true, true)]

theorem GL_card : GL.length = 168 := by decide

theorem stab_order_24 : Stab.length = 24 := by decide

theorem orbit_transitive_on_six :
    sixNonDiag.all
      (fun v => Stab.any (fun M => act M (true, false, false) == v)) = true := by
  decide

end StabRefutation
end SIDESubstrateCluster