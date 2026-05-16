import Lake
open Lake DSL

package «SIDE-substrate-cluster» where
  leanOptions := #[
    ⟨`pp.unicode.fun, true⟩
  ]

@[default_target]
lean_lib SIDESubstrateCluster where
