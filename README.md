# PostgreSQL Docker Compose

## Container Info
| Container Name | Version | Port       | Account   | Password |
|----------------|---------|------------|-----------|----------|
| postgresql     | 17.4    | 5432:5432  | postgres  | 0000     |
| pgbouncer      | latest  | 6432:6432  | pgbouncer | 0000     |

### postgesql Dockerfile
* 安裝 pg_partman 5.2.4
* 安裝 TimescaleDB 2.19.3
    參考[官方指示](https://docs.timescale.com/self-hosted/latest/install/installation-source/)安裝於既有的 PostgreSQL Container 上。
* 安裝 timescaledb-tools
    此工具不會在 git clone & make install TimescalDB 時一起安裝，而是作為獨立套件。

## Command

### 首次啟動服務

```bash
docker-compose up -d --build
```

啟動後先使用 timescaledb-tune 工具調整資料庫參數，調整後需重啟資料庫。

```bash
docker exec -it postgresql bash -c "timescaledb-tune --quiet --yes >> /var/lib/postgresql/data/postgresql.conf" && docker restart postgresql
```

### 啟動服務
```bash
docker-compose up -d
```

### 停止服務
```bash
docker-compose down
```

## Volume
* postgres_data：儲存 PostgreSQL 資料庫資料。

## TimescaleDB

啟動 Container 後，執行以下指令即可安裝 timescaledb Extension。
```sql
CREATE EXTENSION IF NOT EXISTS timescaledb;
```

