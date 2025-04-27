FROM postgres:17.4

# 安裝必要的依賴
RUN apt-get update && apt-get install -y \
    postgresql-server-dev-all \
    git \
    make \
    gcc \
    cmake \
    build-essential \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*

# 下載並安裝 pg_partman
RUN git clone https://github.com/pgpartman/pg_partman.git /tmp/pg_partman \
    && cd /tmp/pg_partman \
    && git checkout 5.2.4 \
    && make install

# 下載並安裝 timescaledb
RUN git clone https://github.com/timescale/timescaledb.git /tmp/timescaledb \
    && cd /tmp/timescaledb \
    && git checkout 2.19.3 \
    && ./bootstrap \
    && cd build && make \
    && make install
    
# 清理臨時文件
RUN rm -rf /tmp/pg_partman /tmp/timescaledb 