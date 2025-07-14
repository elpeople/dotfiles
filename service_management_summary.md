# WSL2 サービス管理まとめ（systemd問題回避版）

## 現在の状況
- systemdが正常に動作していないため、`systemctl`コマンドが使用できない
- 一部のサービスは直接バイナリを実行することで管理可能
- 複雑なサービス（Docker等）はsystemd依存のため起動困難

## 利用可能なサービス管理方法

### 1. 軽量サービス管理ツール
```bash
./lightweight_service_manager.sh <service> <action>
```

**対応サービス:**
- ✅ `cron` - スケジュールタスク
- ✅ `ssh` - SSHサーバー

**利用例:**
```bash
# 状態確認
./lightweight_service_manager.sh cron status
./lightweight_service_manager.sh ssh status

# サービス起動
./lightweight_service_manager.sh cron start

# サービス停止
./lightweight_service_manager.sh cron stop

# サービス再起動
./lightweight_service_manager.sh cron restart

# 全体確認
./lightweight_service_manager.sh check
```

### 2. 直接バイナリ実行
```bash
# Cron起動
sudo /usr/sbin/cron

# SSH起動（デーモンモード）
sudo /usr/sbin/sshd -D &
```

### 3. 手動プロセス管理
```bash
# プロセス確認
ps aux | grep <プロセス名>

# プロセス終了
sudo pkill <プロセス名>
sudo pkill -9 <プロセス名>  # 強制終了

# 特定PID終了
sudo kill <PID>
sudo kill -9 <PID>  # 強制終了

# ポート使用状況
sudo netstat -tlnp | grep <ポート番号>
sudo ss -tlnp | grep <ポート番号>
```

## 現在動作中のサービス

### SSH (PID: 161)
- ポート22でリスニング中
- 正常に動作中

### Cron (PID: 39840)
- スケジュールタスク実行中
- 正常に動作中

## systemd依存で利用困難なサービス
- ❌ Docker - systemd統合が必要
- ❌ Apache2 - systemd依存
- ❌ MySQL/PostgreSQL - systemd依存
- ❌ Nginx - 設定次第で可能だが複雑

## 推奨される対処法

### 完全解決（推奨）
1. PowerShellから: `wsl --shutdown` → `wsl --distribution Debian`
2. WSL内から: `sudo shutdown -r now`

### 一時的回避
- 上記の軽量サービス管理ツールを使用
- 必要に応じて手動でプロセス管理
- systemdに依存しないツールを使用

## 注意事項
- systemdが修復されるまで、複雑なサービスの管理は制限される
- Docker等のコンテナ技術は使用困難
- 定期的にWSL2を再起動することを推奨