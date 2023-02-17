# iOS_ver2

1.Account Balance設計成可以隨著資料筆數增加高度

2.eye用userdefault儲存讓使用者每次進入頁面設定不會跑掉

3.Amount的Saving、Digital、FixedDeposited用userdefault儲存讓使用者每次進入頁面設定不會跑掉

4.menu跟favor都設定為collectionView 未來維護性更好


### 疑問與Bug:
1.Tab最後的service無圖片，自己有用ps去做了一張圖。Tab要完整一點的話還需要其他選取/未選取的圖片，有試過直接設Tint顏色改變，但icon會糊在一起

2.對Request第三題的Amount抱有疑問，題目不太明確

UI的部分 目前預設是Saving，MyAccountBalance那邊沒有地方可以選擇 Saving、Digital、FixedDeposited，不確定要顯示哪一個，有先把資料都寫好，差一個UI的選擇器

API的部分 目前是只有打KHR_Account，USD_Account只有2個USD的欄位沒有KHR，但KHR_Account卻有USD的欄位，所以不太確定要打哪一個，但程式碼有先寫好
</br>
</br>
</br>
![Simulator Screen Shot - iPhone 14 Pro - 2023-02-17 at 10 51 20](https://user-images.githubusercontent.com/56010051/219537813-2b3505e4-8622-4190-b685-8d5222f97749.png)



https://user-images.githubusercontent.com/56010051/219537627-3c78f8d7-fc1d-4b77-9fb3-727c8df67f59.mov

