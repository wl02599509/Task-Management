# [Task Management](https://taskyourself.herokuapp.com/)

這是一套任務管理系統，透過此平台，可以輕鬆管理您的代辦任務。

# 使用語言及框架

**Ruby 3.1.2**

**Rails 7.0.4**

# 部署方式
本專案使用 [Heroku](https://id.heroku.com/login) 進行部署。

1. 於終端機執行 
```
heroku login
```
可不輸入任何值，按下 Enter 後，會開啟 Heroku 登入畫面進行登入。
登入完成即可在終端機執行 heroku 相關指令對伺服器進行操作。

2. 增加 heroku 遠端節點：
```
heroku git:remote -a taskyourself
```

3. 在 master 分支執行:
```
git push heroku master
```
將 master 分支推到 heroku 上，即完成部署。

4. 第一次部署，要執行：
```
heroku run rails db:migrate
```
讓伺服器產生資料表，否則會產生資料庫的相關錯誤訊息。

# 操作說明

## 進入網站首頁
[點擊進入網站](https://taskyourself.herokuapp.com/)即可前往。

## 新增任務
1. 點擊首頁的**增加任務**。
2. 填寫表單。
(請注意！標題與內容皆為必填欄位，且標題有50字上限，內容則有150字上限！)
3. 按下**送出**，即可新增任務。
4. 任務的排序以建立時間由近到遠進行排列。

## 編輯任務
1. 點擊欲修改任務的**編輯任務**。
2. 將欲修改欄位重新編輯。
3. 按下**送出**，即可完成編輯。

## 刪除任務
1. 點擊欲刪除任務的**刪除任務**。
2. 點擊彈跳視窗的**確認**鈕，即可刪除任務。

## 檢視個別任務
1. 點擊欲檢視任務的名稱，即可進入該任務的檢視頁面。