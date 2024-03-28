FROM eclipse-temurin:8-jre-jammy

# バージョン指定
ARG PYTHON_VERSION="3.12.0"
ARG DIGDAG_VERSION="0.10.5"
ARG EMBULK_VERSION="0.11.0"

# 必要なパッケージをインストール
RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
        build-essential \
        gdb \
        lcov \
        pkg-config \
        libbz2-dev \
        libffi-dev \
        libgdbm-dev \
        libgdbm-compat-dev \
        liblzma-dev \
        libncurses5-dev \
        libreadline6-dev \
        libsqlite3-dev \
        libssl-dev \
        lzma \
        lzma-dev \
        tk-dev \
        uuid-dev \
        zlib1g-dev \
        wget && \
    rm -rf /var/lib/apt/lists/*

# 特定のバージョンのPythonのソースをダウンロードし、ビルドしてインストール
RUN wget --no-check-certificate https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz && \
    tar -xf Python-${PYTHON_VERSION-version}.tgz && \
    cd Python-${PYTHON_VERSION} && \
    ./configure --enable-optimizations && \
    make && \
    make install && \
    cd .. && \
    rm -f Python-${PYTHON_VERSION}.tgz

# Digdagをダウンロード
RUN wget --no-check-certificate -O /usr/local/bin/digdag "https://dl.digdag.io/digdag-${DIGDAG_VERSION}" && \
    chmod +x /usr/local/bin/digdag

# Embulkをダウンロード
RUN wget --no-check-certificate -O /usr/local/bin/embulk "https://dl.embulk.org/embulk-${EMBULK_VERSION}.jar" && \
    chmod +x /usr/local/bin/embulk

