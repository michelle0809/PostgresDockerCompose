FROM postgres:17.4

# 安裝基本開發工具和依賴
RUN apt-get update && apt-get install -y \
    postgresql-server-dev-all \
    git \
    make \
    gcc \
    cmake \
    build-essential \
    libssl-dev \
    curl \
    gnupg2 \
    && rm -rf /var/lib/apt/lists/*


# 設置 TimescaleDB 套件庫
RUN curl -fsSL https://packagecloud.io/timescale/timescaledb/gpgkey | gpg --dearmor -o /usr/share/keyrings/timescaledb-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/timescaledb-archive-keyring.gpg] https://packagecloud.io/timescale/timescaledb/debian bookworm main" | tee /etc/apt/sources.list.d/timescaledb.list

# 安裝 TimescaleDB 相關工具
RUN apt-get update && \
    apt-get install -y timescaledb-tools && \
    rm -rf /var/lib/apt/lists/*

# 安裝 pg_partman
RUN git clone https://github.com/pgpartman/pg_partman.git /tmp/pg_partman && \
    cd /tmp/pg_partman && \
    git checkout 5.2.4 && \
    make install

# 安裝 TimescaleDB
RUN git clone https://github.com/timescale/timescaledb.git /tmp/timescaledb && \
    cd /tmp/timescaledb && \
    git checkout 2.19.3 && \
    ./bootstrap && \
    cd build && make && \
    make install

# 清理臨時文件
RUN rm -rf /tmp/pg_partman /tmp/timescaledb 