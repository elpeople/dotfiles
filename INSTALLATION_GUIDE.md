# dotfiles インストールガイド

このドットファイルリポジトリには、様々なツールや設定が含まれています。
`stow` を使用してシンボリックリンクを管理していますが、一部のツールは手動でのインストールや追加の設定が必要です。

## はじめに

このガイドは、`stow` で管理されていない、または追加の手動設定が必要なツールについて説明します。

## 前提条件

*   `git`
*   `stow`
*   `Homebrew` (macOS/Linux) または `scoop` (Windows)
*   `zsh` (メインシェルとして推奨)
*   `bash`
*   `vim` または `neovim`

## 手動インストールが必要なツール

### 1. zoxide

`zoxide` は、頻繁にアクセスするディレクトリを学習し、素早く移動できるツールです。

*   **インストール方法:**
    *   **Homebrew (macOS/Linux):**
        ```bash
        brew install zoxide
        ```
    *   **scoop (Windows):**
        ```bash
        scoop install zoxide
        ```
    *   その他のインストール方法は、[zoxideの公式GitHubリポジトリ](https://github.com/ajeetdsouza/zoxide#installation) を参照してください。

*   **dotfilesでの設定ファイル:**
    *   `zsh`: `~/dotfiles/zsh/.zshrc.mac`, `~/dotfiles/zsh/.zshrc.lin`, `~/dotfiles/zsh/.zshrc.wsl` に `eval "$(zoxide init zsh)"` が記述されています。
    *   `bash`: `~/dotfiles/bash/.bashrc.mac`, `~/dotfiles/bash/.bashrc.lin`, `~/dotfiles/bash/.bashrc.wsl` に `eval "$(zoxide init bash)"` が記述されています。

### 2. Powerlevel10k (p10k)

Powerlevel10kは、Zsh用の高速でカスタマイズ可能なテーマです。

*   **インストール方法:**
    *   `zinit` を使用してインストールされます。`~/.zshrc` に以下の行が含まれていることを確認してください。
        ```zsh
        zinit light romkatv/powerlevel10k
        ```
    *   インストール後、`p10k configure` を実行してプロンプトをカスタマイズします。

*   **推奨フォント:**
    *   Powerlevel10kの表示を最適化するためには、[MesloLGS NF](https://github.com/ryanoasis/nerd-fonts/releases/latest) のインストールが強く推奨されます。ダウンロード後、システムにインストールし、ターミナルエミュレータ（iTerm2など）のフォント設定で `MesloLGS NF` を選択してください。

*   **dotfilesでの設定ファイル:**
    *   `~/.p10k.zsh`: `p10k configure` によって生成される設定ファイルです。
    *   `~/.config/zsh/p10k-catppuccin.zsh`: Catppuccinの色をPowerlevel10kに適用するための設定ファイルです。`~/.zshrc` で `~/.p10k.zsh` の後に読み込まれるように設定されています。

### 3. dein.vim (Vim/Neovim プラグインマネージャー)

`dein.vim` は、Vim/Neovim用の高速なプラグインマネージャーです。

*   **インストール方法:**
    *   `~/.vimrc` または `init.vim` に記述されている `dein.vim` のインストールスクリプトを実行します。通常、Vim/Neovimを初めて起動した際に自動的にインストールされます。
    *   手動でインストールする場合は、[dein.vimの公式GitHubリポジトリ](https://github.com/Shougo/dein.vim#installation) を参照してください。

*   **dotfilesでの設定ファイル:**
    *   `~/dotfiles/vim/.vimrc`
    *   `~/dotfiles/vim/dein.toml`: プラグインの定義と設定が含まれています。Catppuccinテーマもここで設定されています。

### 4. rmpc (MPDクライアント)

`rmpc` は、MPD (Music Player Daemon) のターミナルクライアントです。

*   **インストール方法:**
    *   `rmpc` はRustで書かれているため、`cargo` を使ってインストールできます。
        ```bash
        cargo install rmpc
        ```
    *   その他のインストール方法は、[rmpcの公式GitHubリポジトリ](https://github.com/garkimasera/rmpc#installation) を参照してください。

*   **dotfilesでの設定ファイル:**
    *   `~/.config/rmpc/config.ron`: `rmpc` の設定ファイルです。Catppuccinテーマのパレットが設定されています。

### 5. bat (catの代替)

`bat` は、シンタックスハイライトとGit統合を備えた `cat` コマンドの代替です。

*   **インストール方法:**
    *   **Homebrew (macOS/Linux):**
        ```bash
        brew install bat
        ```
    *   **scoop (Windows):**
        ```bash
        scoop install bat
        ```
    *   その他のインストール方法は、[batの公式GitHubリポジトリ](https://github.com/sharkdp/bat#installation) を参照してください。

*   **dotfilesでの設定ファイル:**
    *   `~/.zshrc` および `~/.bashrc` で `alias cat='bat'` が設定されています。

### 6. fzf (ファジーファインダー)

`fzf` は、コマンドラインで使える汎用的なファジーファインダーです。

*   **インストール方法:**
    *   **Homebrew (macOS/Linux):**
        ```bash
        brew install fzf
        ```
    *   **scoop (Windows):**
        ```bash
        scoop install fzf
        ```
    *   インストール後、`$(fzf --bash)` または `$(fzf --zsh)` を実行してシェルに統合します。

*   **dotfilesでの設定ファイル:**
    *   `~/.zshrc` および `~/.bashrc` で `fzf` の設定とCatppuccinテーマの読み込み (`~/.config/fzf/catppuccin-mocha.sh`) が記述されています。

### 7. eza (lsの代替)

`eza` は、`ls` コマンドの代替で、より多くの機能と美しい表示を提供します。

*   **インストール方法:**
    *   **Homebrew (macOS/Linux):**
        ```bash
        brew install eza
        ```
    *   その他のインストール方法は、[ezaの公式GitHubリポジトリ](https://github.com/eza-community/eza#installation) を参照してください。

*   **dotfilesでの設定ファイル:**
    *   `~/.zshrc` および `~/.bashrc` で `~/.config/eza/catppuccin-mocha.sh` が読み込まれ、Catppuccinの色が適用されます。

### 8. ripgrep (grepの代替)

`ripgrep` は、高速な再帰的grepです。

*   **インストール方法:**
    *   **Homebrew (macOS/Linux):**
        ```bash
        brew install ripgrep
        ```
    *   **scoop (Windows):**
        ```bash
        scoop install ripgrep
        ```
    *   その他のインストール方法は、[ripgrepの公式GitHubリポジトリ](https://github.com/BurntSushi/ripgrep#installation) を参照してください。

*   **dotfilesでの設定ファイル:**
    *   `~/.zshrc` および `~/.bashrc` で `~/.config/ripgrep/catppuccin-mocha.sh` が読み込まれ、Catppuccinの色が適用されます。

## 補足事項

*   **Catppuccinテーマ:** 各ツールのCatppuccinテーマは、`~/.config/` 以下に配置されています。
*   **`stow`:** このリポジトリは `stow` を使用して管理されています。`stow` の基本的な使い方は、[GNU Stowの公式ドキュメント](https://www.gnu.org/software/stow/manual/stow.html) を参照してください。
*   **環境変数:** `~/.zshrc` や `~/.bashrc` で `PATH` などの環境変数が設定されています。必要に応じて調整してください。

このガイドが、あなたの環境をセットアップするのに役立つことを願っています。
