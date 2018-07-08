FROM library/arangodb:3.2.15

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

ENV AZURE_CLI_VERSION "0.10.17"
ENV NODEJS_APT_ROOT "node_6.x"
ENV NODEJS_VERSION "6.11.3"

RUN apt-get update -qq && \
    apt-get install -qqy --no-install-recommends\
      apt-transport-https \
      build-essential \
      curl \
      ca-certificates \
      git \
      lsb-release \
      python-all \
      rlwrap \
      vim \
      nano \
      jq && \
    rm -rf /var/lib/apt/lists/* && \
    curl -sL https://deb.nodesource.com/setup_6.x | bash - && \
      apt-get install -y nodejs && \
      npm install --global azure-cli@${AZURE_CLI_VERSION} && \
      azure --completion >> ~/azure.completion.sh && \
      echo 'source ~/azure.completion.sh' >> ~/.bashrc && \
      azure telemetry --disable && \
      azure config mode arm

COPY backup.sh /
ENTRYPOINT /backup.sh
