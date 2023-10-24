#!/bin/bash

read -r -d '' json_data <<'EOF'
{
    "2023-10-24T08:00:00Z": "Started the day with a morning run. Feeling energized and ready to tackle the day's tasks.",
    "2023-10-24T14:30:00Z": "Worked on a challenging project all afternoon. Made good progress but need to review it tomorrow.",
    "2023-10-25T09:15:00Z": "Met with a client in the morning. Discussed project requirements and outlined a plan.",
    "2023-10-25T20:00:00Z": "Relaxed in the evening with a good book. It's important to unwind after a busy day."
}
EOF

# Use jq to filter entries for the 25th of October 2023
result=$(echo "$json_data" | jq 'to_entries[] | select(.key | startswith("2023-10-25"))')

# Print the filtered entries
echo "$result"
