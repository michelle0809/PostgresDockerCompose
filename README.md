# PostgreSQL Docker Compose

## Service Info
| Service    | Version | Port       | Account   | Password |
|------------|---------|------------|-----------|----------|
| PostgreSQL | 17.4    | 5432:5432  | postgres  | 0000     |
| pgBouncer  | 1.20.1  | 6432:6432  | pgbouncer | 0000     |

## Command

啟動服務
```bash
docker-compose up -d
```

停止服務
```bash
docker-compose down
```

## Volume
postgres_data：儲存 PostgreSQL 資料庫資料。
pgbouncer_data: 儲存 pgBouncer 設定。