# 株式会社ゆめみ iOS エンジニアコードチェック課題

## 概要

本プロジェクトは株式会社ゆめみのコーディング課題です。

## アプリ仕様

本アプリは GitHub のリポジトリーを検索するアプリです。

![動作イメージ](README_Images/app.gif)

### 環境

- IDE：基本最新の安定版（本概要更新時点では Xcode 14.2）
- Swift：基本最新の安定版（本概要更新時点では Swift 5.7）
- 開発ターゲット：基本最新の安定版（本概要更新時点では iOS 16.1）

### 使用したライブラリ

- [JGProgressHUD](https://github.com/JonasGessner/JGProgressHUD)
ロード画面を表示するために使用

- [SDWebImage](https://github.com/SDWebImage/SDWebImage)
画像表示用に使用

### 動作

1. 何かしらのキーワードを入力
2. GitHub API（`search/repositories`）でリポジトリーを検索し、結果一覧を概要（リポジトリ名、オーナーアイコン、プロジェクト言語、Star 数、Watcher 数、Fork 数）で表示
3. 特定の結果を選択したら、該当リポジトリの詳細（リポジトリ名、オーナーアイコン、プロジェクト言語、Star 数、Watcher 数、Fork 数、Issue 数）を表示
4. 詳細画面内のリンクからGitHubのWebページへ移動できます。

### 参考にしたサイト
## [Qiita](https://qiita.com/SHOBLOG/items/5083e43558581cbf0dee)
