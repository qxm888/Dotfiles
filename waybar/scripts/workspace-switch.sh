#!/bin/bash

direction="${1:-next}"

workspaces=$(hyprctl workspaces -j 2>/dev/null | python3 -c "
import sys,json
ws = json.load(sys.stdin)
ids = [w['id'] for w in sorted(ws, key=lambda x: x['id']) if w['id'] > 0]
print(' '.join(str(i) for i in ids))
")

active=$(hyprctl activeworkspace -j 2>/dev/null | python3 -c "import sys,json; print(json.load(sys.stdin)['id'])")

ids=($workspaces)
if [ ${#ids[@]} -eq 0 ]; then
    exit 0
fi

for i in "${!ids[@]}"; do
    if [ "${ids[$i]}" = "$active" ]; then
        current_idx=$i
        break
    fi
done

if [ "$direction" = "next" ]; then
    next_idx=$(( (current_idx + 1) % ${#ids[@]} ))
else
    next_idx=$(( (current_idx - 1 + ${#ids[@]}) % ${#ids[@]} ))
fi

target="${ids[$next_idx]}"
hyprctl dispatch "hl.dsp.focus({workspace = $target})" 2>/dev/null
