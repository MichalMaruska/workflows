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
