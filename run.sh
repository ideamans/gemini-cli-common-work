#!/bin/bash

cd "$(dirname "$0")" || exit 1

# .envファイルが必要
if [ -f ".env" ]; then
    set -a
    source ".env"
    set +a
else
    echo "エラー: .envファイルが見つかりません" >&2
    exit 1
fi

# 残作業があるか判定する関数
has_backlog() {
    if [ ! -f "tasks.tsv" ]; then
        echo "エラー: tasks.tsvが見つかりません" >&2
        return 1
    fi
    
    # タブ区切りで2列目(ステータス)が空の行があるかチェック
    while IFS=$'\t' read -r col1 col2 rest; do
        # 空行をスキップ
        [ -z "$col1" ] && continue
        # 2列目が空の場合、真(0)を返す
        if [ -z "$col2" ]; then
            return 0
        fi
    done < tasks.tsv
    
    # 2列目が空の行が見つからない場合、偽(1)を返す
    return 1
}

# メインループ
while true; do
    # 処理するタスクがあるかチェック
    if ! has_backlog; then
        echo "処理するタスクがありません。終了します。"
        exit 0
    fi
    
    echo "タスクを処理しています..."
    gemini -y -m gemini-2.5-flash -p "@GEMINI.md に従い @tasks.tsv を完成に導いてください。"
    gemini_exit_code=$?
    
    # 処理後もタスクが残っているかチェック
    if has_backlog; then
        if [ $gemini_exit_code -eq 0 ]; then
            echo "残りタスクがあります。10秒後に再実行します..."
            sleep 10
        else
            echo "エラーが発生しました。10分後に再実行します..."
            sleep 600
        fi
    else
        echo "すべてのタスクが完了しました。終了します。"
        exit 0
    fi
done