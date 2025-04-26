FROM postgres:latest

# 安裝必要的依賴
RUN apt-get update && apt-get install -y \
    postgresql-server-dev-all \
    git \
    make \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# 下載並安裝 pg_partman
RUN git clone https://github.com/pgpartman/pg_partman.git /tmp/pg_partman \
    && cd /tmp/pg_partman \
    && make install

# 清理臨時文件
RUN rm -rf /tmp/pg_partman 