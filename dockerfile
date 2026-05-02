# for my component builds
# ghcr.io/michal-maruska/apt-builder:latest


FROM debian:unstable-slim
RUN apt-get update && apt-get dist-upgrade -y && \
    apt-get install -y --no-install-recommends \
      reprepro \
      curl \
      ca-certificates \
      gnupg \
    && rm -rf /var/lib/apt/lists/*
