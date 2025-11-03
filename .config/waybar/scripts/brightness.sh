#!/bin/bash

value=$(brightnessctl get)
max=$(brightnessctl max)
percent=$((100 * value / max))
echo "{\"text\":\"  ${percent}%\"}"

