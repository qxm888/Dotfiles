#!/bin/bash

cpu_line_1=$(grep '^cpu ' /proc/stat)
sleep 0.3
cpu_line_2=$(grep '^cpu ' /proc/stat)

idle1=$(echo "$cpu_line_1" | awk '{print $5+$6}')
total1=$(echo "$cpu_line_1" | awk '{for(i=2;i<=NF;i++) s+=$i; print s}')

idle2=$(echo "$cpu_line_2" | awk '{print $5+$6}')
total2=$(echo "$cpu_line_2" | awk '{for(i=2;i<=NF;i++) s+=$i; print s}')

diff_idle=$((idle2 - idle1))
diff_total=$((total2 - total1))

if [ "$diff_total" -eq 0 ]; then
    cpu=0
else
    cpu=$((100 * (diff_total - diff_idle) / diff_total))
fi

if [ "$cpu" -lt 30 ]; then class="low"
elif [ "$cpu" -lt 60 ]; then class="medium"
elif [ "$cpu" -lt 85 ]; then class="high"
else class="critical"
fi

echo "{\"text\": \"󰍛 ${cpu}%\", \"class\": \"$class\", \"percentage\": $cpu}"
