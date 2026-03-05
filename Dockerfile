FROM node:22-bookworm-slim

ARG MINDCRAFT_REPO=https://github.com/mindcraft-bots/mindcraft.git
ARG MINDCRAFT_REF=develop

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    git \
    ca-certificates \
    python3 \
    python3-pip \
    xvfb \
    xauth \
    libgl1-mesa-dev \
    libgles2-mesa-dev \
    libosmesa6-dev \
    build-essential \
    libcairo2-dev \
    libpango1.0-dev \
    libjpeg-dev \
    libgif-dev \
    librsvg2-dev \
    libxi-dev \
    libxinerama-dev \
    libxrandr-dev && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN git clone --depth 1 --branch "${MINDCRAFT_REF}" "${MINDCRAFT_REPO}" /app
RUN npm install

CMD ["npm", "start"]
