FROM ubuntu:noble

# Set environment variables
ENV ANDROID_SDK_ROOT=/usr/lib/android-sdk
ENV FLUTTER_SDK_ROOT=/usr/lib/flutter
ENV FLUTTER_SDK_VERSION=3.38.9

# Include flutter and android tools in path
ENV PATH="${PATH}:${FLUTTER_SDK_ROOT}/bin:${ANDROID_SDK_ROOT}/cmdline-tools/latest/bin:${ANDROID_SDK_ROOT}/platform-tools"

# Enable noninteractive installation
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies and tools
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y \
    build-essential \
    clang \
    cmake \
    curl \
    git-all \
    libc6:amd64 libstdc++6:amd64 lib32z1 libbz2-1.0:amd64 \
    libglu1-mesa \
    libgtk-3-0 \
    libgtk-3-dev \
    mesa-utils \
    ninja-build \
    openjdk-17-jdk \
    pkg-config \
    unzip \
    watchman \
    wget \
    xz-utils \
    zip && \
    rm -rf /var/lib/apt/lists/*

# Add flutter to safe directory in git
RUN git config --global --add safe.directory /usr/lib/flutter

# Configure git user name and email
RUN git config --global user.name "Build Bot" \
    && git config --global user.email "bot@example.com"

# Download and install Android Command Line Tools
RUN mkdir -p ${ANDROID_SDK_ROOT}/cmdline-tools && \
    wget -q -O commandlinetools.zip "https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip" && \
    unzip -q commandlinetools.zip -d ${ANDROID_SDK_ROOT}/cmdline-tools && \
    mv ${ANDROID_SDK_ROOT}/cmdline-tools/cmdline-tools ${ANDROID_SDK_ROOT}/cmdline-tools/latest && \
    rm commandlinetools.zip

# Accept Android SDK licenses and install necessary components
RUN yes | ${ANDROID_SDK_ROOT}/cmdline-tools/latest/bin/sdkmanager --licenses && \
    ${ANDROID_SDK_ROOT}/cmdline-tools/latest/bin/sdkmanager "platform-tools" "platforms;android-36" "build-tools;28.0.3"

# Install Flutter SDK
RUN curl -OL https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_SDK_VERSION}-stable.tar.xz && \
    tar -xf flutter_linux_${FLUTTER_SDK_VERSION}-stable.tar.xz -C /usr/lib/ && \
    rm flutter_linux_${FLUTTER_SDK_VERSION}-stable.tar.xz

# Disable Flutter telemetry
RUN flutter --disable-analytics

# Default shell to bash
SHELL ["/bin/bash", "-c"]
