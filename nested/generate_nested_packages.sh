#!/bin/bash

base_dir="n"
rm -rf "$base_dir"
mkdir -p "$base_dir"

# Create f1.go at nested_files root (no folder)
cat > "$base_dir/f1.go" <<EOF
package f1

import (
	"nested/n/f2"
)

func F1() int {
	f2.F2()
	return 2 + 2
}
EOF

parent_path="$base_dir/f2"
mkdir -p "$parent_path"

for i in $(seq 2 800); do
  next=$((i+1))

  if [ "$i" -eq 800 ]; then
    # For the last file, no import, just return
    cat > "$parent_path/f${i}.go" <<EOF
package f${i}

func F${i}() int {
	return 2 + 2
}
EOF
  else
    # Calculate import path for next package relative to base_dir
    import_path="f2"
    for ((j=3; j<=next; j++)); do
      import_path="$import_path/f$j"
    done

    # Create the go file in the current folder with fixed import statement
    cat > "$parent_path/f${i}.go" <<EOF
package f${i}

import (
	"nested/n/$import_path"
)

func F${i}() int {
	f${next}.F${next}()
	return 2 + 2
}
EOF
  fi

  # Create next folder inside current folder
  parent_path="$parent_path/f${next}"
  mkdir -p "$parent_path"
done

# Create last file f1000.go inside last folder
# cat > "$parent_path/f1000.go" <<EOF
# package f1000
#
# func F1000() int {
# 	return 2 + 2
# }
# EOF

# Create main.go at root to call f1.F1()
cat > main.go <<EOF
package main

import (
	"nested/n"
)

func main() {
	f1.F1()
}
EOF

echo "Generated nested_files structure with nested imports up to f800.go and main.go"
