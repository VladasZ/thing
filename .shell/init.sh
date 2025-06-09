#!/usr/bin/env bash

BASHRC="$HOME/.bashrc"
SOURCE_LINE="source \$HOME/dev/thing/.shell/shell.sh"

# Create .bashrc if it doesn't exist
if [ ! -f "$BASHRC" ]; then
  touch "$BASHRC"
  echo "Created $BASHRC"
fi

# Check if the source line exists
if ! grep -Fxq "$SOURCE_LINE" "$BASHRC"; then
  echo "$SOURCE_LINE" >> "$BASHRC"
  echo "Added source line to $BASHRC"
else
  echo "Source line already present in $BASHRC"
fi
