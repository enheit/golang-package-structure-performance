#!/bin/bash

mkdir -p files

# Create 1000 package files, each in its own folder
for i in $(seq 1 1000); do
  mkdir -p "files/file_${i}"
  cat > "./files/file_${i}/file_${i}.go" <<EOF
package file_${i}

func Test${i}() int {
	return 2 + 2
}
EOF
done

# Create main.go that imports all packages and calls their TestN functions storing results in variables
cat > main.go <<EOF
package main

import (
EOF

for i in $(seq 1 1000); do
  echo "	\"linear/files/file_${i}\"" >> main.go
done

cat >> main.go <<EOF
)

func main() {
EOF

for i in $(seq 1 1000); do
  echo "	_ = file_${i}.Test${i}()" >> main.go
done

cat >> main.go <<EOF
}
EOF

echo "Generated 1000 files (one per folder) in ./files and main.go (calls stored in variables)"
