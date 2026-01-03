#!/bin/bash

# -------------------------------------------------
# Source RTL file (manual edit)
# -------------------------------------------------
RTL_SOURCE="CLA.v"

# Files to update
SYNTH_FILE="synthesis_run.tcl"
STA_FILE="cla_sta_1.tcl"

# -------------------------------------------------
# Extract N ONLY from module CLA_N
# -------------------------------------------------
N=$(grep -oP 'module\s+CLA_N\s*#\(\s*parameter\s+N\s*=\s*\K[0-9]+' "$RTL_SOURCE")

if [ -z "$N" ]; then
  echo "ERROR: Could not extract N from $RTL_SOURCE"
  exit 1
fi

echo "Using N = $N"

# -------------------------------------------------
# Update synthesis + STA
# Match ONLY: CLA_gate_level_<number>_bit.v
# -------------------------------------------------
sed -i "s#CLA_gate_level_[0-9]\+_bit\.v#CLA_gate_level_${N}_bit.v#g" \
    "$SYNTH_FILE" \
    "$STA_FILE"

echo "Updated synthesis and STA to use:"
echo "  CLA_gate_level_${N}_bit.v"
