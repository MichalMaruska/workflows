# for my component builds
# ghcr.io/michal-maruska/apt-builder:latest


FROM debian:unstable-slim
RUN apt-get update && apt-get dist-upgrade -y && \
    apt-get install -y --no-install-recommends \
            software-properties-common curl  && \
      # reprepro \
      # curl \
      # ca-certificates \
      # gnupg \


      # 1. Create a build user
      useradd -m builder && \
      # I can use my specific versions!
      curl https://michal-maruska.github.io/apt-repo/maruska.asc -o /etc/apt/trusted.gpg.d/maruska.asc && \
      # apt-add-repository -y
      echo "deb [signed-by=/etc/apt/trusted.gpg.d/maruska.asc] https://michal-maruska.github.io/apt-repo sid main" > /etc/apt/sources.list.d/maruska.list  && \

      # github:
      mkdir -p -m 755 /etc/apt/keyrings &&\
      curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | gpg --dearmor -o /etc/apt/keyrings/githubcli-archive-keyring.gpg && \
      chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg && \
      echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | \
            tee /etc/apt/sources.list.d/github-cli.list > /dev/null && \
      # RESET:
      apt-get update && \
      apt-get install -y gh && \
      # remove the GH source:
      rm -f /etc/apt/sources.list.d/github-cli.list  \
            /etc/apt/keyrings/githubcli-archive-keyring.gpg &&  \
      # clean up a bit
      apt-get purge -y curl && \
      # Now I can use my versions !!!
      apt-get install -y --no-install-recommends \
      devscripts equivs \
      build-essential \
      devscripts \
      debhelper \
      git-buildpackage python3-typing-extensions && \
      apt-get autoremove -y && \
      rm -rf /var/lib/apt/lists/*
