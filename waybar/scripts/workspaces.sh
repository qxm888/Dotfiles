#!/bin/bash

data=$(hyprctl workspaces -j 2>/dev/null)
if [ -z "$data" ]; then
    echo '{"text": ""}'
    exit 0
fi

active=$(hyprctl activeworkspace -j 2>/dev/null | python3 -c "import sys,json; print(json.load(sys.stdin)['id'])")

workspaces=$(echo "$data" | python3 -c "
import sys,json
ws = json.load(sys.stdin)
ids = [w['id'] for w in sorted(ws, key=lambda x: x['id']) if w['id'] > 0]
print(' '.join(str(i) for i in ids))
")

output=""
for id in $workspaces; do
    icons_num=$id
    case "$icons_num" in
        1) icon="①";;
        2) icon="②";;
        3) icon="③";;
        4) icon="④";;
        5) icon="⑤";;
        6) icon="⑥";;
        7) icon="⑦";;
        8) icon="⑧";;
        9) icon="⑨";;
        10) icon="⑩";;
        *) icon="$id";;
    esac
    if [ "$id" = "$active" ]; then
        output+="<span color='#D0E8FF' bgcolor='#313244CC'> ${icon} </span> "
    else
        output+="<span color='#6c7086' bgcolor='#31324455'> ${icon} </span> "
    fi
done

output="${output% }"
echo "{\"text\": \"$output\", \"tooltip\": \"Workspaces: $workspaces\"}"
