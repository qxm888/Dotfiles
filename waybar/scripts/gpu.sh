#!/bin/bash

vram=$(nvidia-smi --query-gpu=memory.used,memory.total --format=csv,noheader,nounits 2>/dev/null)

if [ -z "$vram" ]; then
    echo '{"text": "󰢮 N/A", "class": "low", "percentage": 0}'
    exit 0
fi

used=$(echo "$vram" | awk -F', ' '{print $1}')
total=$(echo "$vram" | awk -F', ' '{print $2}')

if [ "$total" -eq 0 ]; then
    echo '{"text": "󰢮 N/A", "class": "low", "percentage": 0}'
    exit 0
fi

pct=$((used * 100 / total))

if [ "$pct" -lt 30 ]; then class="low"
elif [ "$pct" -lt 60 ]; then class="medium"
elif [ "$pct" -lt 85 ]; then class="high"
else class="critical"
fi

echo "{\"text\": \"󰢮 ${pct}%\", \"class\": \"$class\", \"percentage\": $pct}"
