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



## Command

建制服務
```bash
docker-compose build
```

啟動服務
```bash
docker-compose up -d
```

停止服務
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

