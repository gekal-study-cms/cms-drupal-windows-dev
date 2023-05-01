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

## 参照

1. [System requirements](https://www.drupal.org/docs/getting-started/system-requirements)
2. [Database server requirements](https://www.drupal.org/docs/system-requirements/database-server-requirements)
