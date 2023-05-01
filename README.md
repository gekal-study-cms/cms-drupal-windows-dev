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
    
    # サービスの削除(管理者権限要)
    Stop-Service -Name "MySQL"
    C:\drupal\mysql80\bin\mysqld.exe --remove

    # コマンドプロンプトの接続
    C:\drupal\mysql80\bin\mysql.exe -u root --skip-password
    ```

4. Apacheのセットアップ

    ```powershell
    # サービスの登録＆開始(管理者権限要)
    C:\drupal\Apache24\bin\httpd.exe -k install
    
    # サービスの削除(管理者権限要)
    C:\drupal\Apache24\bin\httpd.exe -k uninstall

    # サービスの起動
    C:\drupal\Apache24\bin\httpd.exe -k start
    ```

## 参照

1. [System requirements](https://www.drupal.org/docs/getting-started/system-requirements)
2. [Database server requirements](https://www.drupal.org/docs/system-requirements/database-server-requirements)
