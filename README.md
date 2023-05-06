# Drupal の Windows 環境整理

## System requirements

> Drupal 9

| ソフト | バージョン         | メモ                                    |
| ------ | ------------------ | --------------------------------------- |
| Apache | 2.x                | Drupal 9 requires at least Apache 2.4.7 |
| PHP    | 8.1 (note 1 below) | Recommended                             |
| MySQL  | 5.7.8+             | Use 8.0.x                               |

## 環境のセットアップ

1. 資材をローカルにクローンします。

    ```powershell
    git clone https://github.com/gekal-study-cms/cms-drupal-windows-dev.git /drupal
    ```

2. 必要なソフトをダウンロードします。

    ```powershell
    .\setup.ps1
    ```

3. MySqlのセットアップ

    ```powershell
    # データの初期化
    # 　既存のデータを削除したい場合、[C:\drupal\mysql80\data]フォルダーを削除してください。
    C:\drupal\mysql80\bin\mysqld.exe --initialize-insecure --user=mysql
    
    # サービスの登録＆開始(管理者権限要)
    C:\drupal\mysql80\bin\mysqld.exe --install MySQL
    Start-Service -Name "MySQL"
    
    # サービスの停止&削除(管理者権限要)
    Stop-Service -Name "MySQL"
    C:\drupal\mysql80\bin\mysqld.exe --remove

    # サービスの再起動(管理者権限要)
    Restart-Service -Name "MySQL"
    ```

4. Apacheのセットアップ

    ```powershell
    # サービスの登録＆開始(管理者権限要)
    C:\drupal\Apache24\bin\httpd.exe -k install
    
    # サービスの削除(管理者権限要)
    C:\drupal\Apache24\bin\httpd.exe -k uninstall

    # サービスの起動
    C:\drupal\Apache24\bin\httpd.exe -k start

    # サービスの停止
    C:\drupal\Apache24\bin\httpd.exe -k stop

    # サービスの再起動
    C:\drupal\Apache24\bin\httpd.exe -k restart
    ```

5. DBスキーマの準備

    ```powershell
    # コマンドプロンプトの接続
    C:\drupal\mysql80\bin\mysql.exe -u root --skip-password
    ```

    > DB&Userの作成SQL

    ```sql
    CREATE DATABASE IF NOT EXISTS drupal;
    -- DROP DATABASE IF EXISTS drupal;
    
    CREATE USER 'drupal' IDENTIFIED BY 'password';
    GRANT ALL PRIVILEGES ON drupal.* TO 'drupal';
    ```

    > DBダンプ取得(CMD実施してください)

    ```cmd
    REM スキーマ
    C:\drupal\mysql80\bin\mysqldump.exe --user=root --skip-password --single-transaction --no-data --routines drupal > C:\drupal\dump\01.drupal.schema.sql
    REM データ
    C:\drupal\mysql80\bin\mysqldump.exe --user=root --skip-password drupal --single-transaction --no-create-info > C:\drupal\dump\02.drupal.data.sql
    ```

    > DBダンプの復元(CMD実施してください)

    ```cmd
    REM スキーマ
    C:\drupal\mysql80\bin\mysql.exe --user=root --skip-password --default-character-set=utf8 drupal < C:\drupal\dump\01.drupal.schema.sql
    REM データ
    C:\drupal\mysql80\bin\mysql.exe --user=root --skip-password --default-character-set=utf8 drupal < C:\drupal\dump\02.drupal.data.sql
    ```

6. Drupal本体設定

    [こちら](https://www.drupal.org/project/drupal/releases?version=9)からDrupalをダウンロードして、`source`フォルダーに解凍してください。

    - DB設定項目

        | 項目       | 設定値    |
        | ---------- | --------- |
        | ホスト     | localhost |
        | ポート     | 3306      |
        | ユーザ     | drupal    |
        | パスワード | drupal    |
        | スキーマ   | password  |

    - 設定完了後の接続

        URL: <http://localhost/>

        | ユーザー | パスワード |
        | -------- | ---------- |
        | gekal    | 123456     |

## VSCodeのデバッグ

> デバッグコンフィグ: `./.vscode/launch.json`
> ソースパス: `C:\drupal\source`

```json
"pathMappings": {
    "C:\\drupal\\source": "${workspaceFolder}\\source"
}
```

VS Code で `F5` キーを押して、デバッグを開始します。
ブレークポイントを付けて、通常通りにデバッグできます。

![Debug View](/images/debug-view.png)

## 参照

1. [System requirements](https://www.drupal.org/docs/getting-started/system-requirements)
2. [Database server requirements](https://www.drupal.org/docs/system-requirements/database-server-requirements)
