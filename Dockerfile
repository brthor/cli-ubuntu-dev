#
# Copyright (c) .NET Foundation and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for full license information.
#

# Dockerfile that creates a container suitable to build dotnet-cli
FROM ubuntu:14.04

# Misc Dependencies for build
RUN apt-get update && apt-get -qqy install curl unzip gettext sudo

# This could become a "microsoft/coreclr" image, since it just installs the dependencies for CoreCLR (and stdlib)
RUN echo "deb http://llvm.org/apt/trusty/ llvm-toolchain-trusty-3.6 main"  | tee /etc/apt/sources.list.d/llvm.list && \
    curl http://llvm.org/apt/llvm-snapshot.gpg.key | apt-key add - && \
    apt-get update && apt-get -qqy install\
    libc6 \
    libedit2 \
    libffi6 \
    libgcc1 \
    libicu52 \
    liblldb-3.6 \
    libllvm3.6 \
    liblttng-ust0 \
    liblzma5 \
    libncurses5 \
    libpython2.7 \
    libstdc++6 \
    libtinfo5 \
    libunwind8 \
    liburcu1 \
    libuuid1 \
    zlib1g \
    libasn1-8-heimdal \
    libcomerr2 \
    libcurl3 \
    libgcrypt11 \
    libgnutls26 \
    libgpg-error0 \
    libgssapi3-heimdal \
    libgssapi-krb5-2 \
    libhcrypto4-heimdal \
    libheimbase1-heimdal \
    libheimntlm0-heimdal \
    libhx509-5-heimdal \
    libidn11 \
    libk5crypto3 \
    libkeyutils1 \
    libkrb5-26-heimdal \
    libkrb5-3 \
    libkrb5support0 \
    libldap-2.4-2 \
    libp11-kit0 \
    libroken18-heimdal \
    librtmp0 \
    libsasl2-2 \
    libsqlite3-0 \
    libssl1.0.0 \
    libtasn1-6 \
    libwind0-heimdal

# Install Dotnet CLI dependencies.
# clang is required for dotnet-compile-native
RUN apt-get -qqy install clang-3.5

# Install Build Prereqs
RUN apt-get -qq install -y debhelper build-essential devscripts git cmake

# Use clang as c++ compiler
RUN update-alternatives --install /usr/bin/c++ c++ /usr/bin/clang++-3.5 100
RUN update-alternatives --set c++ /usr/bin/clang++-3.5

# Clone the Cli Repo
RUN git clone https://github.com/dotnet/cli /opt/code/cli

# Set working directory
WORKDIR /opt/code/cli
