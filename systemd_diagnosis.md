# WSL2 systemd 問題の診断結果

## 現在の状況
- WSL2でsystemdが有効に設定されているが、systemctlがバスに接続できない
- `/sbin/init`はsystemdにリンクされているが、systemdのプライベートソケットが正常に作成されていない
- `Failed to connect to bus: No such file or directory` エラーが発生

## 原因
WSL2のsystemd統合に問題があり、systemdのD-Busソケットが正常に初期化されていない

## 解決方法

### 【推奨】完全な解決方法
1. **WindowsのコマンドプロンプトまたはPowerShellから：**
   ```cmd
   wsl --shutdown
   wsl --distribution Debian
   ```

2. **または、WSL内から：**
   ```bash
   sudo shutdown -r now
   ```

### 一時的な回避策
systemctlの代わりに以下を使用：

1. **serviceコマンド：**
   ```bash
   sudo service <service-name> start|stop|status|restart
   ```

2. **直接制御：**
   ```bash
   sudo /etc/init.d/<service-name> start|stop|status|restart
   ```

3. **手動でプロセス管理：**
   ```bash
   # プロセス確認
   ps aux | grep <service-name>
   
   # 手動起動（例：nginx）
   sudo /usr/sbin/nginx
   
   # 手動停止
   sudo pkill <service-name>
   ```

## 設定ファイル
`/etc/wsl.conf` は正しく設定されています：
```ini
[boot]
systemd=true

[user]
default=elpeople

[interop]
enabled=true
appendWindowsPath=true

[network]
generateHosts=true
generateResolvConf=true
```

## 注意事項
- この問題はWSL2の再起動で解決される可能性が高い
- systemdが正常に動作するまで、systemctlコマンドは使用できない
- 一時的にはserviceコマンドやinit.dスクリプトを使用する