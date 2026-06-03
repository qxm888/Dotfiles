#!/bin/bash

mem=$(LANG=C free | awk 'NR==2 {if($2>0) printf "%.0f", $3/$2 * 100; else print 0}')

if [ "$mem" -lt 40 ]; then class="low"
elif [ "$mem" -lt 70 ]; then class="medium"
elif [ "$mem" -lt 90 ]; then class="high"
else class="critical"
fi

echo "{\"text\": \"󰘚 ${mem}%\", \"class\": \"$class\", \"percentage\": $mem}"
