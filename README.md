# Gemini CLI 汎用エージェント活用デモ - ニュースサイト調査

## 概要

このプロジェクトは、Gemini CLI を使用して、コーディング作業ではなく一般的な調査タスクを実行するデモンストレーションです。具体的には、日本の主要な新聞系ニュースサイトにアクセスランキング機能が採用されているかを調査するタスクを Gemini CLI に依頼します。

## プロジェクトの目的

- **Gemini CLI の汎用性の実証**: コード生成以外のタスクでも Gemini CLI が有効に活用できることを示す
- **ウェブ調査の自動化**: 複数のニュースサイトの調査を効率的に実行
- **構造化データの収集**: TSV 形式で調査結果を体系的に記録

## 調査対象

`tasks.tsv`ファイルに記載された以下の新聞系ニュースサイト：

- 読売新聞
- 朝日新聞
- 毎日新聞
- 日経新聞
- 産経新聞
- サンスポ
- ジャパンタイムズ
- スポーツ報知
- 日刊工業新聞
- 日刊スポーツ
- スポニチ
- 東スポ
- 水産経済新聞
- 東京新聞
- 日本農業新聞
- 共同通信

## 調査項目

各ニュースサイトについて以下の情報を収集：

1. **URL**: 各新聞社の公式ウェブサイト URL
2. **アクセスランキングの有無**: サイトにアクセスランキング機能があるか
3. **アクセスランキングの名称**: 実際に使用されている機能の名称（例：「アクセスランキング」「人気記事」「よく読まれている記事」など）

## ファイル構成

```
gemini-cli-common-agent/
├── README.md      # このファイル
├── tasks.tsv      # 調査対象と結果を記録するTSVファイル
├── run.sh         # 実行スクリプト（必要に応じて）
├── .env.example   # 環境変数の設定例
└── .env           # 実際の環境変数設定（要作成）
```

## 必要な準備

### Brave サーチ API キーの設定

このプロジェクトでは、ウェブサイトの調査に Brave サーチ API を使用します。

1. [Brave Search API](https://brave.com/search/api/)で API キーを取得
2. `.env.example`ファイルをコピーして`.env`ファイルを作成：
   ```bash
   cp .env.example .env
   ```
3. `.env`ファイルを編集し、取得した API キーを設定：
   ```
   BRAVE_API_KEY=your_api_key_here
   ```

### Gemini CLI のセットアップ

Gemini CLI は以下のいずれかの方法で利用できます：

- **個人無償版**: Gemini の個人アカウントで無料で利用可能
- **API キー版**: Google AI Studio で API キーを取得して利用

詳細は[Gemini CLI 公式ドキュメント](https://ai.google.dev/gemini-api/docs/cli)を参照してください。

## 使用方法

1. 必要な環境変数を設定（上記参照）
2. `run.sh`を起動

## 動作の様子

<iframe width="560" height="315" src="https://www.youtube.com/embed/ovPyi44V1sE?si=1tGWGFa6pfK2Fopg" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

## このデモが示すこと

1. **タスクの多様性**: Gemini CLI はコーディングだけでなく、ウェブ調査のような汎用的なタスクにも対応可能
2. **効率的な情報収集**: 手動で行うと時間がかかる反復的な調査作業を自動化

## 注意事項

- 各サイトの構造は頻繁に変更される可能性があるため、調査結果は実施時点のものです
- サイトによってはアクセスランキングが特定のセクションにのみ存在する場合があります
