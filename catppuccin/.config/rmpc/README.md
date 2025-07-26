# rmpc Catppuccin Configuration

## 🎯 `?69h` 表示問題の完全修正

### 修正内容
- `enable_mouse: false` に設定
- `enable_config_hot_reload: false` に設定
- 複数のマウスレポートモードを無効化
- 専用の修正スクリプトを作成

### 🚀 使用方法

1. **ターミナルをリセット** (最初に実行):
   ```bash
   ~/.config/rmpc/fix-terminal.sh
   ```

2. **通常の起動**:
   ```bash
   rmpc
   ```

3. **問題が続く場合のラッパースクリプト**:
   ```bash
   ~/.config/rmpc/rmpc-wrapper.sh
   ```

4. **tmuxでの使用**:
   ```bash
   # tmux設定で以下を使用
   bind C-f display-popup -w 80% -h 80% -E '~/.config/rmpc/rmpc-wrapper.sh'
   ```

### 🎨 Catppuccin テーマ

- **テーマファイル**: `themes/catppuccin-mocha.ron`
- **設定**: `theme: Some("catppuccin-mocha")`
- **カラーパレット**: Catppuccin Mocha (ダークテーマ)

### 🔧 トラブルシューティング

#### `?69h` 問題の段階的解決

1. **緊急リセット** (最初に試す):
   ```bash
   ~/.config/rmpc/emergency-reset.sh
   ```

2. **基本テスト**:
   ```bash
   ~/.config/rmpc/test-rmpc.sh
   ```

3. **クリーンな起動**:
   ```bash
   ~/.config/rmpc/rmpc-clean.sh
   ```

4. **通常の起動**:
   ```bash
   rmpc
   ```

#### その他の問題

- **テーマが適用されない場合**:
  ```bash
  # テーマを有効化
  sed -i 's/theme: None,/theme: Some("catppuccin-mocha"),/' ~/.config/rmpc/config.ron
  ```

- **設定エラーの場合**:
  ```bash
  cp ~/.config/rmpc/config.ron.backup ~/.config/rmpc/config.ron
  ```

- **完全リセット**:
  ```bash
  rm ~/.config/rmpc/config.ron
  rmpc config > ~/.config/rmpc/config.ron
  ```

### 📁 ファイル構成
```
~/.config/rmpc/
├── config.ron                 # メイン設定ファイル
├── themes/
│   └── catppuccin-mocha.ron   # Catppuccinテーマ
├── rmpc-wrapper.sh            # ラッパースクリプト
├── fix-terminal.sh            # ターミナル修正スクリプト
└── README.md                  # このファイル
```