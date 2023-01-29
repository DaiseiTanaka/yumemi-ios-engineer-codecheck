# 株式会社ゆめみ iOS エンジニアコードチェック課題

## 概要

本プロジェクトは株式会社ゆめみ様のiOSアプリケーション用のコーディング課題です。

## アプリ仕様

本アプリは GitHub のリポジトリーを検索するアプリです。

![動作イメージ](README_Images/app.gif)


## 環境

- IDE：基本最新の安定版（本概要更新時点では Xcode 14.2）
- Swift：基本最新の安定版（本概要更新時点では Swift 5.7）
- 開発ターゲット：基本最新の安定版（本概要更新時点では iOS 16.1）


## 使用したライブラリ

- [JGProgressHUD](https://github.com/JonasGessner/JGProgressHUD)
ロード画面を表示するために使用

- [SDWebImage](https://github.com/SDWebImage/SDWebImage)
画像表示用に使用


## 動作

1. 何かしらのキーワードを入力
2. GitHub API（`search/repositories`）でリポジトリーを検索し、結果一覧を概要（リポジトリ名、オーナーアイコン、リポジトリの説明文、プロジェクト言語、Star 数、Watcher 数、Fork 数）で表示。
3. 特定の結果を選択したら、該当リポジトリの詳細（リポジトリ名、オーナーアイコン、リポジトリの説明文、プロジェクト言語、Star 数、Watcher 数、Fork 数、Issue 数）を表示。
4. (追加した機能)詳細画面内のリンクからGitHubのWebページへ移動できます。


## Issuesについて
- [元のリポジトリ](https://github.com/yumemi-inc/ios-engineer-codecheck)からIssuesをコピーしようとしたがエラーが発生していてコピーできなかったため、CommitのコメントにどのIssuesに対処したのかを書きました。


## 工夫した点

- 新機能としてリポジトリのリンクへ飛べるようにしました。新機能というには大袈裟ですが、全ての詳細データをアプリ内で表示するよりUIがシンプルになり、UXが向上すると考えたため実装しました。
- 検索結果の画面でも最低限の情報を確認できるように、CellのUIを設計しました。


## 苦労した点
- テストコードの経験が浅く、作成に一番時間がかかりました。


## 反省点
- Commitごとに変更内容の分担を意識していたが、ところどころCommitを忘れ、一度に複数の機能をPushしてしまった。
- 初めの方のCommitのコメントにどのIssuesへ対処したのかを書くのを忘れていた。


## 参考にしたサイト

- [参考サイト1](https://qiita.com/SHOBLOG/items/5083e43558581cbf0dee)
- [参考サイト2](https://zenn.dev/ikeh1024/articles/1b8c0ecc11c99f)
