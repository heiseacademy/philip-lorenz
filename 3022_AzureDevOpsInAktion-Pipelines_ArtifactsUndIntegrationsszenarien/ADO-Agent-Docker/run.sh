# Set variables:
export AZP_URL="https://dev.azure.com/ORG"
export AZP_TOKEN=""
export AZP_POOL="MahlzeitExpress"
export AZP_AGENT_NAME="Container01"

# Build image:
docker build --platform=linux/amd64 -t azure-devops-agent .

# Default:
docker run -e AZP_URL=$AZP_URL \
           -e AZP_TOKEN=$AZP_TOKEN \
           -e AZP_POOL=$AZP_POOL \
           -e AZP_AGENT_NAME=$AZP_AGENT_NAME \
           azure-devops-agent