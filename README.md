# Daily Desk 2.1 — 雲端同步測試版

## 功能
- 日記：日期、標題、內文、搜尋、自動儲存、刪除
- 行事曆：月曆、每日待辦、時間、備註、完成狀態
- 記帳：收入支出、分類、月份切換、編輯刪除、月結餘
- 離線優先：IndexedDB 儲存；JSON 匯出／合併匯入
- 雲端：選用 Supabase Email/Password 登入與 RLS 隔離資料

## 本機試用
需使用 http://localhost 或 HTTPS，不建議直接雙擊 index.html。
若有 Python：在本資料夾執行 `python -m http.server 8080`，瀏覽 http://localhost:8080。
同一 Wi-Fi 其他裝置不能直接以 HTTP 區網 IP 安裝 PWA；請部署至 HTTPS 網址。

## 跨裝置安裝
把本資料夾部署到 GitHub Pages、Cloudflare Pages 或其他 HTTPS 靜態託管。
- iPhone/iPad：Safari → 分享 → 加入主畫面。
- Android：Chrome → 安裝應用程式／加入主畫面。
- Windows：Edge/Chrome → 安裝網站為應用程式。
注意：瀏覽器對安裝圖示格式的支援可能不同，必要時另外製作 PNG 192/512 圖示。

## 啟用雲端同步
1. 建立 Supabase 專案，於 SQL Editor 執行 `supabase.sql`。
2. Authentication → Providers → Email 啟用電子郵件登入，建議啟用郵件驗證。
3. 在 Daily Desk「設定／同步」填入專案 URL 和公開 anon/publishable key（不是 secret/service_role key）。
4. 建立帳號／登入，按「立即同步」。每台裝置重複步驟 3–4。
5. 變更資料後會嘗試同步；若網路中斷，可於恢復連線後按「立即同步」。

## 安全與限制
- 本機 IndexedDB 並非加密保險箱；共用電腦請使用獨立作業系統帳號。
- 雲端傳輸使用 HTTPS、Supabase Auth 與 RLS，但**不是端對端加密**，伺服器管理者仍可能接觸明文資料。
- 本版本採更新時間（last-write-wins）衝突解決，同一篇日記在多裝置同時編輯可能覆蓋較舊版本。
- 雲端同步單次最多抓取 10000 筆；大量資料須改成分頁同步。
- 雲端登入狀態儲存在 localStorage；正式上線前建議強化 token 管理、CSP、衝突處理與安全測試。
- 本版沒有推播提醒、附件、舊版 SQLite 自動遷移，也沒有正式商店發行。
- 靜態網頁公開部署後，其他人可開啟網站，但資料預設保存在各自裝置；登入資料由 RLS 隔離。


## 2.1 帳戶資料隔離與使用須知
- 訪客本機資料和各登入帳戶使用**不同的 IndexedDB 資料庫**，登出會切回訪客資料；不同帳號不會自動混合本機紀錄。
- 首次登入後的個人資料庫是空的；若要將舊訪客資料同步到帳號，請先在訪客模式匯出 JSON，登入後再匯入。請只匯入自己的資料。
- **重要：這仍是測試版，不適合直接保存機密日記、真實財務資料。** 同一筆資料在兩台裝置同時編輯時仍可能衝突；此版沒有端對端加密、密碼找回介面、完整安全測試。
- 不要將 `.env`、資料備份、密碼、Supabase service_role/secret key 放到 Public GitHub 儲存庫。
- Supabase RLS 必須先執行並驗證。公開 publishable/anon key 可以放在客戶端，但不等於資料公開授權。
- 透過 GitHub Pages 發布的是程式碼；個人資料由瀏覽器 IndexedDB 與您設定的 Supabase 專案儲存。
- 登出不等於刪除裝置資料；共用電腦請使用獨立作業系統帳號並定期清理。
