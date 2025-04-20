# PostgreSQL Docker Compose

## Container Info
| Container      | Version | Port       | Account   | Password |
|----------------|---------|------------|-----------|----------|
| postgresql     | latest  | 5432:5432  | postgres  | 0000     |
| pgbouncer      | latest  | 6432:6432  | pgbouncer | 0000     |
| pgbench-client | latest  | -          | -         | -        |

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
* postgres_data：儲存 PostgreSQL 資料庫資料。

## pgBouncer Config
1. pgbouncer.ini

    對資料庫的連線設定需在此文檔修改，需設定其 IP、Port、連線資料庫名稱。

    [databases] 區域設定連線資訊。預設只有一組 postgres 資料庫的連線，要手動新增其他組。

    因對 pgBouncer 來說，每個資料庫會採用分開的 Pool，故每個資料庫要單獨一行設定。

2. userlist.txt

    檔案格式是一行為一組帳密。

## pgbench
單純想使用 PostgreSQL 的 pgbench 工具，用來測試連線 5432/6432 Port 的差異。

```bash
docker exec -it pgbench-client bash
```
```bash
pgbench -i --host postgres-db --port 5432 -U postgres test_database
pgbench --host postgres-db --port 5432 -U postgres -t 50 -c 10 -v -C test_database

pgbench -i --host pgbouncer --port 6432 -U postgres test_database
pgbench --host pgbouncer --port 6432 -U postgres -t 50 -c 10 -v -C test_database
```