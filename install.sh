#!/bin/bash
# OpenCode Bug Bounty — install skills into ~/.config/opencode/skills/

set -e

INSTALL_DIR="${HOME}/.config/opencode/skills"
mkdir -p "${INSTALL_DIR}"

echo "Installing Bug Bounty skills..."
echo ""

# Copy all skills
for skill_dir in .opencode/skills/*/; do
    skill_name=$(basename "$skill_dir")
    mkdir -p "${INSTALL_DIR}/${skill_name}"
    cp "${skill_dir}SKILL.md" "${INSTALL_DIR}/${skill_name}/SKILL.md"
    echo "✓ Installed skill: ${skill_name}"
done

# Install commands
COMMANDS_DIR="${HOME}/.config/opencode/commands"
mkdir -p "${COMMANDS_DIR}"

for cmd_file in .opencode/commands/*.md; do
    cmd_name=$(basename "$cmd_file")
    cp "$cmd_file" "${COMMANDS_DIR}/${cmd_name}"
    echo "✓ Installed command: ${cmd_name}"
done

echo ""
echo "Done! Skills installed to ${INSTALL_DIR}"
echo "Commands installed to ${COMMANDS_DIR}"
echo ""

# Offer Burp MCP setup
echo "─────────────────────────────────────────────"
echo "Optional: Burp Suite MCP Integration"
echo "─────────────────────────────────────────────"
echo ""
echo "Connect to PortSwigger's Burp MCP server for live HTTP traffic visibility."
echo "See mcp/burp-mcp-client/README.md for setup instructions."
echo ""
read -p "Set up Burp MCP now? (y/N): " setup_burp
if [[ "$setup_burp" =~ ^[Yy]$ ]]; then
    echo ""
    echo "To connect Burp MCP, add this to your OpenCode MCP config:"
    echo ""
    echo "  opencode.json  →  mcpServers section"
    echo ""
    echo "Then add to the mcpServers section:"
    cat mcp/burp-mcp-client/config.json | grep -A 10 '"burp"'
    echo ""
    echo "And set your Burp API key:"
    echo "  export BURP_API_KEY=\"your-api-key-here\""
    echo ""
fi

echo "Start hunting:"
echo "  opencode ."
echo "  /recon target.com"
echo "  /hunt target.com"
