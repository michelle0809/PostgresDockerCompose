# PostgreSQL Docker Compose

## Service Info
| Service    | Version | Port       | Account   | Password |
|------------|---------|------------|-----------|----------|
| PostgreSQL | latest  | 5432:5432  | postgres  | 0000     |
| pgBouncer  | latest  | 6432:6432  | pgbouncer | 0000     |

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