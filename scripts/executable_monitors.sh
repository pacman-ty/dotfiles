#!/bin/bash

CONFIG="$HOME/.config/hypr/config/monitor.conf"

if grep -q "disabled = true" "$CONFIG"; then
  # If currently true → make it false
  sed -i 's/disabled = true/disabled = false/' "$CONFIG"
elif grep -q "disabled = false" "$CONFIG"; then
  # If currently false → make it true
  sed -i 's/disabled = false/disabled = true/' "$CONFIG"
else
  echo "No 'disabled' line found in $CONFIG"
  exit 1
fi
