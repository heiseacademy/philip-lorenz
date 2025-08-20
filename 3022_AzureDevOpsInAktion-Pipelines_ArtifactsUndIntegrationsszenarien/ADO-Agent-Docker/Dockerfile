FROM ubuntu:22.04

# Install required packages
RUN apt-get update && \
    apt-get install -y curl unzip libcurl4 libunwind8 gettext apt-transport-https ca-certificates gnupg software-properties-common sudo && \
    apt-get clean

# Create a user and set up working dir
RUN useradd -m azuredevops && mkdir -p /azp && chown azuredevops /azp

WORKDIR /azp

# Copy script and make it executable before user switch
COPY start.sh .
RUN chmod +x start.sh

# Switch to unprivileged user
USER azuredevops

ENTRYPOINT ["./start.sh"]
