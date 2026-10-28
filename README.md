# Daily Desk 2.1

跨平台日記、行事曆／待辦、記帳 PWA 測試專案。

## 部署

將 `DailyDesk_2_1_Cloud_Sync_Test.zip` 解壓縮，並將 `daily-desk-pwa` 資料夾**內**的 `index.html`、`app.js`、`style.css`、`sw.js`、`manifest.webmanifest`、`icon.svg`、`supabase.sql` 上傳到此儲存庫根目錄（不是整個資料夾）。

接著到 Settings → Pages → Build and deployment → Deploy from a branch，選擇 `main` 和 `/(root)`，儲存後等待部署。

網站網址預計為 https://elohist0805-dot.github.io/daily-desk/ 。

**注意：** 公開儲存庫不得提交個人日記、帳目備份、Supabase service_role 金鑰或其他秘密。雲端同步正式使用前須完成 Supabase Auth、RLS、同步及權限驗證。