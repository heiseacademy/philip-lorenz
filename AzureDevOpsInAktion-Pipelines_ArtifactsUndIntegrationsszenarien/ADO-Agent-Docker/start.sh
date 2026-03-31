#!/bin/bash
set -e

AGENT_VERSION="4.255.0"
AGENT_URL="https://vstsagentpackage.azureedge.net/agent/${AGENT_VERSION}/vsts-agent-linux-x64-${AGENT_VERSION}.tar.gz"

echo "Starting Azure DevOps agent setup..."
echo "Checking required environment variables..."

# Validate required variables
: "${AZP_URL:?Environment variable AZP_URL not set}"
: "${AZP_TOKEN:?Environment variable AZP_TOKEN not set}"
: "${AZP_POOL:=Default}"
: "${AZP_AGENT_NAME:=$(hostname)}"

echo "✅ AZP_URL=$AZP_URL"
echo "✅ AZP_POOL=$AZP_POOL"
echo "✅ AZP_AGENT_NAME=$AZP_AGENT_NAME"

echo "Downloading agent version $AGENT_VERSION from:"
echo "$AGENT_URL"

# Download and extract agent
curl -LsS "$AGENT_URL" | tar -xz

echo "Configuring agent..."
./config.sh --unattended \
  --url "$AZP_URL" \
  --auth pat \
  --token "$AZP_TOKEN" \
  --pool "$AZP_POOL" \
  --agent "$AZP_AGENT_NAME" \
  --acceptTeeEula \
  --replace

echo "✅ Agent configured. Starting..."
exec ./run.sh
