#!/bin/bash

TODO_FILE="/home/leminhohoho/.local/share/todo.md"

if [[ ! -f "$TODO_FILE" ]]; then
    touch "$TODO_FILE"
fi

PENDING_COUNT=$(grep -c "^\s*- \[ \]" "$TODO_FILE")
DOING_COUNT=$(grep -c "^\s*- \[~\]" "$TODO_FILE")
DONE_COUNT=$(grep -c "^\s*- \[x\]" "$TODO_FILE")
LATEST_TODO=$(grep "^\s*- \[~\]" "$TODO_FILE" | head -n 1 | sed 's/^\s*-\s\[\~\]\s*//')

echo "{\"text\":\"<span color='#8EC07C'> ${DONE_COUNT}</span> <span color='#458588'> ${DOING_COUNT}</span> <span color='#D79921'> ${PENDING_COUNT}</span>\", \"tooltip\":\"\n ${LATEST_TODO} \n\"}"
