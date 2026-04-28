#!/bin/bash
cat << 'INNER_EOF' > /tmp/mint.patch
--- mint.json
+++ mint.json
@@ -73,6 +73,7 @@
       "pages": [
         "architecture/manifest",
-        "architecture/prime-invariant"
+        "architecture/prime-invariant",
+        "architecture/interface-constraint"
       ]
     },
INNER_EOF
patch mint.json < /tmp/mint.patch
