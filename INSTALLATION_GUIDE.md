# dotfiles インストールガイド

このドットファイルリポジトリは、`ghq` で管理し、`stow` を使用してシンボリックリンクを張る構成になっています。

## はじめに

このガイドでは、`stow` で管理されていないツールや、追加の手動設定が必要な項目について説明します。

## 推奨されるセットアップ手順

1.  **Homebrewのインストール**:
    ```bash
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    ```

2.  **必須ツールのインストール**:
    ```bash
    brew install ghq stow fzf bat eza ripgrep zoxide
    ```

3.  **リポジトリのクローン**:
    ```bash
    ghq get git@github.com:elpeople/dotfiles.git
    cd $(ghq list -p -m dotfiles)
    ```

4.  **シンボリックリンクの適用**:
    ```bash
    # 個別に適用する場合
    stow zsh -t ~
    stow tmux -t ~
    
    # 一括で適用する場合
    stow bash nb vim zsh starship tmux wezterm ranger fzf catppuccin -t ~
    ```

## 各ツールの詳細設定

### 1. Zsh (zinit)
Zshのプラグイン管理には `zinit` を使用しています。
- **設定ファイル**: `zsh/.zshrc.mac` (macOSの場合)
- **反映方法**: `source ~/.zshrc`
- 初回起動時に `zinit` が自動インストールされます。

### 2. Powerlevel10k (p10k)
- プロンプトのセットアップ: `p10k configure`
- **フォント**: [MesloLGS NF](https://github.com/romkatv/powerlevel10k#manual-font-installation) のインストールを推奨します。

### 3. Tmux (TPM)
- プラグインマネージャー `TPM` が含まれています。
- **インストール**: tmuxを起動し、`prefix` (Ctrl+g) + `I` を押してプラグインをインストールしてください。

### 4. Ranger (Colorschemes)
- `catppuccin_mocha` テーマが適用されています。
- 設定ファイル: `ranger/.config/ranger/rc.conf`

### 5. WezTerm
- **配色**: Catppuccin Mochaをベースに、タブの色をRangerのディレクトリ色 (#af875f) に合わせています。
- 設定ファイル: `wezterm/.config/wezterm/wezterm.lua`

### 6. fzf (Catppuccin)
- 視認性を高めたカスタムCatppuccinテーマを適用しています。
- 設定ファイル: `catppuccin/.config/fzf/catppuccin-mocha.sh`

## インストールスクリプト (install.sh) の機能

リポジトリ直下の `install.sh` は、Stowの操作を簡略化・安全化するために以下の機能を備えています。

### 1. パッケージの自動検知
リポジトリ内のディレクトリを自動的にスキャンしてパッケージとして認識します。新しい設定フォルダを追加した際、スクリプトを修正することなくすぐに `install` コマンドで使用可能です。
※ `old`, `node_modules`, `backup` などの非設定フォルダは自動的に除外されます。

### 2. 自動バックアップ機能
`stow` 実行時にホームディレクトリ側の既存ファイルと競合が発生した場合、それらを自動的に `~/.dotfiles_backup/日付/` ディレクトリに退避させます。これにより、既存の設定を上書きして失うリスクを回避できます。

### 3. 実行場所の非依存
`ghq` 管理下のどのパスから実行しても、スクリプト自身の場所を基準に正しく動作します。

---

## 便利なエイリアス
セットアップ完了後、以下のエイリアスが使用可能になります：
- `gcd`: dotfilesディレクトリへ移動
- `g`: ghqリポジトリをインタラクティブに選択して移動

## パッケージ一覧
現在インストールされている Homebrew パッケージについては [Casks.md](Casks.md) を参照してください。
