# PostgreSQL Docker Compose

## Container Info
| Container Name | Version | Port       | Account   | Password |
|----------------|---------|------------|-----------|----------|
| postgresql     | latest  | 5432:5432  | postgres  | 0000     |
| pgbouncer      | latest  | 6432:6432  | pgbouncer | 0000     |

### postgesql Dockerfile
* 安裝 pg_partman 並配置相關參數
```
shared_preload_libraries = 'pg_partman_bgw'  # 啟用 pg_partman 的背景工作程序
pg_partman_bgw.interval = 3600 # 設定背景工作程序執行間隔(秒)
pg_partman_bgw.role = 'postgres' # 設定背景工作程序使用的帳號
pg_partman_bgw.dbname = 'postgres,test_database' # 設定背景工作程序使用的資料庫(多個資料庫則用逗號分隔)
```


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

## pg_partman
介紹請參考此文。

以下筆記 part_config 欄位用途，個人理解僅供參考。
| 欄位名稱 | 用途 | 範例值 |
|---------|------|--------|
| parent_table | 父表名稱 | 'public.test_partman' |
| control | 作為 Partition Key 的欄位 | 'created_at' |
| partition_interval | 每個 Partition 長度 | '1 day' 或 '1 month' |
| partition_type | Partition 類型 | 'range' 或 'list' |
| premake | 領先於當前時間的分區數 | 7 |
| automatic_maintenance | 是否啟動自動維護 | 'on' 或 'off' |
| template_table | 模板表 | NULL |
| retention | 定義資料保存時長，需是一個可轉換為 interval 或  bigint 的值 | '30 days' |
| retention_schema | 會覆蓋 retention_keep_table 的設定，若有設定則會將逾期分區搬移到 retention_schema 的 schema 下而不會刪除 | NULL |
| retention_keep_index | 分離逾期分區時是否要刪除該分區的 index | true |
| retention_keep_table | 逾期資料是否要保留，設定 true 則只是 DETACH 但不刪除 | false |
| epoch | 若 Partition Key 是 integer/bigint 欄位，透過此參數設定該數字所代表的意義 (seconds/milliseconds/microseconds/nanoseconds) | 'none' |
| constraint_cols | 約束條件 | NULL |
| optimize_constraint | 將在包含資料的最新分區後N個分區上建立約束 | 30 |
| infinite_time_partitions | 預設情況下，如果沒有插入新數據，則不會在基於時間的集合中建立新的分區，以防止建立無限數量的空白表 | false |
| datetime_string | 分區名稱時間戳記字串格式 | 'YYYYMMDD' |
| jobmon | 是否透過 pg_jobmon 監控工作 | false |
| sub_partition_set_full | ? (未研究) | false |
| undo_in_progress | 若執行 undo_partition，會將執行的表設定為 true，則 run_maintenance_proc() 會跳過該表的處理 | false |
| inherit_privileges | 是否將父表權限繼承給子表。當需要直接 SELECT 分區而非父表時才會需要開啟此設定。 | false |
| constraint_valid | ? (未研究) | true |
| subscription_refresh | ? (未研究) | NULL |
| ignore_default_data | ? (未研究) | true |
| maintenance_order | ? (未研究) | NULL |
| retention_keep_publication | ? (未研究) | false |
| maintenance_last_run | 上次維護時間 | timestamptz |