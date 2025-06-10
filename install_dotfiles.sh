#!/bin/sh

# dotfilesディレクトリのパス
DOTFILES_DIR="$HOME/dotfiles"

# シンボリックリンクを安全に作成する関数
create_symlink() {
    local source="$1"
    local target="$2"
    
    # ソースファイルが存在するかチェック
    if [ ! -e "$source" ]; then
        echo "警告: $source が存在しません。スキップします。"
        return 1
    fi
    
    # ターゲットディレクトリを作成（必要な場合）
    local target_dir=$(dirname "$target")
    if [ ! -d "$target_dir" ]; then
        echo "ディレクトリを作成: $target_dir"
        mkdir -p "$target_dir"
    fi
    
    # 既存のファイル/ディレクトリ/シンボリックリンクを削除
    if [ -e "$target" ] || [ -L "$target" ]; then
        echo "既存の $target を削除"
        rm -rf "$target"
    fi
    
    # シンボリックリンクを作成
    echo "シンボリックリンクを作成: $target -> $source"
    ln -sf "$source" "$target"
}

echo "dotfilesのシンボリックリンクを作成中..."

# ホームディレクトリ直下のファイル
create_symlink "$DOTFILES_DIR/.bashrc" "$HOME/.bashrc"
create_symlink "$DOTFILES_DIR/.vimrc" "$HOME/.vimrc"
create_symlink "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"

# ディレクトリ
create_symlink "$DOTFILES_DIR/.tmux" "$HOME/.tmux"
create_symlink "$DOTFILES_DIR/.w3m" "$HOME/.w3m"

# .configディレクトリ内
create_symlink "$DOTFILES_DIR/ranger" "$HOME/.config/ranger"

# その他のファイル（適切なパスに修正）
create_symlink "$DOTFILES_DIR/dein.toml" "$HOME/.config/nvim/dein.toml"

echo "完了しました！"