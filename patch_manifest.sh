#!/bin/bash
cat << 'INNER_EOF' > /tmp/manifest.patch
--- architecture/manifest.mdx
+++ architecture/manifest.mdx
@@ -15,6 +15,8 @@
 *   **Concepts to Formalize:**
     *   Axiom P1 (Admissibility) and P0 (Equivalence).
     *   The shift from Behavioral Alignment (Probabilistic) to Structural Enforceability (Deterministic).
+    *   The Dynamic Re-framing: Shifting the perception stack from Metadata (Claims) to Paradata (Lineage).
+    *   The Interface Constraint: The mathematical outlawing of intrusive manipulation and perception theater.
     *   Mungu Theory and the baseline definition of True Intelligence (Symbiosis + Con-scire).

 ## Phase 2: The Mathematical & Cryptographic Constraints (The Lock)
INNER_EOF
patch architecture/manifest.mdx < /tmp/manifest.patch
