#!/bin/bash
set -euo pipefail

ECC_REPO="https://github.com/affaan-m/ECC"
CONFIG_REPO="https://github.com/ariswibono/opencode-configs"
CONFIG_DIR="$HOME/.config/opencode"

echo "=== OpenCode ECC Install ==="
echo ""

# Prerequisites
echo "[check] prerequisites..."
command -v git >/dev/null 2>&1 || { echo "install git first"; exit 1; }
command -v npm  >/dev/null 2>&1 || { echo "install npm first"; exit 1; }
command -v opencode >/dev/null 2>&1 || { echo "install opencode first: curl -fsSL https://opencode.ai/install | bash"; exit 1; }

# Step 1: Clone ECC base
echo "[1/3] Cloning ECC base..."
ECC_TMP=$(mktemp -d)
git clone --depth 1 "$ECC_REPO" "$ECC_TMP"
mkdir -p "$CONFIG_DIR"/skills
mkdir -p "$CONFIG_DIR"/plugins
mkdir -p "$CONFIG_DIR"/prompts/agents
cp -r "$ECC_TMP/skills"          "$CONFIG_DIR/skills/ecc"
cp -r "$ECC_TMP/.opencode/plugins"  "$CONFIG_DIR/plugins/ecc"
cp -r "$ECC_TMP/.opencode/prompts/agents" "$CONFIG_DIR/prompts/agents/ecc"
rm -rf "$ECC_TMP"

# Step 2: Clone custom config
echo "[2/3] Cloning custom config..."
git clone "$CONFIG_REPO" "$CONFIG_DIR"

# Step 3: Install npm dependencies
echo "[3/3] Installing npm dependencies..."
cd "$CONFIG_DIR" && npm install

# Done
echo ""
echo "=== Install complete ==="
echo "Run 'opencode' to start."
