# macOS（Apple Silicon）用設定
if [[ "$(uname)" == "Darwin" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
  fi

  # Linux（WSL）用設定
  if [[ "$(uname -r)" == *"WSL"* ]]; then
    # 例: Linux用のPATH調整やcondaなどの初期化
      export PATH="$HOME/.local/bin:$PATH"
      fi
