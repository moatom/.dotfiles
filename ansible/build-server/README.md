```bash
ansible-playbook playbook.yml
```

✅ 構成要件まとめ（再確認）

| 機能          | 方法                                             |
| ----------- | ---------------------------------------------- |
| WOL 有効化     | ethtoolで設定・永続化                                 |
| RTCスケジュール起動 | 毎日2:00にスクリプトで `/sys/class/rtc/...` 書き込み        |
| 自動スリープ      | systemd-logind設定または `idle.target` に遷移          |
| 祝日対応        | 祝日APIから取得 or 手動定義                              |
| CI/CDトリガー   | GitHub Actions → Wake用Webhook → `wakeonlan` 実行 |


✅ Ansible構成ファイル

    roles/rtc_wakeup/
    roles/wol/
    roles/suspend/
    roles/wake_webhook/
    playbook.yml

