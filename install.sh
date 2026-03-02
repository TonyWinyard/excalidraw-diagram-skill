#!/bin/bash
# Install the Excalidraw Diagram skill for Claude Code
# Run from the repo directory: ./install.sh

set -e

SKILL_DIR="$HOME/.claude/skills/excalidraw-diagram"
VAULT_DIR="$HOME/Obsidian_Vaults/master_vault/Excalidraw"

echo "Installing Excalidraw Diagram skill..."

# Create skill directory
mkdir -p "$SKILL_DIR/references"

# Copy skill files
cp SKILL.md "$SKILL_DIR/"
cp references/color-palette.md "$SKILL_DIR/references/"
cp references/element-templates.md "$SKILL_DIR/references/"
cp references/json-schema.md "$SKILL_DIR/references/"
cp references/render_excalidraw.py "$SKILL_DIR/references/"
cp references/render_template.html "$SKILL_DIR/references/"
cp references/pyproject.toml "$SKILL_DIR/references/"

echo "Skill files copied to $SKILL_DIR"

# Install Python dependencies
echo "Installing render pipeline dependencies..."
cd "$SKILL_DIR/references"
uv sync
uv run playwright install chromium

echo "Render pipeline ready."

# Create Excalidraw folder in vault if it exists
if [ -d "$HOME/Obsidian_Vaults/master_vault" ]; then
  mkdir -p "$VAULT_DIR"
  echo "Created Excalidraw output folder at $VAULT_DIR"
else
  echo "Note: Obsidian vault not found at ~/Obsidian_Vaults/master_vault/"
  echo "Create the Excalidraw/ folder manually in your vault when ready."
fi

echo ""
echo "Done. The excalidraw-diagram skill is now available in Claude Code."
echo "Try: 'Create an Excalidraw diagram showing...'"
