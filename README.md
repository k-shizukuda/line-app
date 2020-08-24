# README

## アカウント名
### TAKEOUT探します

<image src="https://user-images.githubusercontent.com/67094874/91012949-f069db80-e621-11ea-8659-a184faa41d16.png" width="35%">
  
##  概要
### テイクアウトできる飲食店を探すチャットボットです。

### Bot-basic-ID  @454iijoo

<image src="https://user-images.githubusercontent.com/67094874/91012733-881afa00-e621-11ea-9bd6-a0c7d02ed180.png" width="40%">

# このアプリについて

## 制作した経緯

飲食店のテイクアウト需要が高まり、様々なお店がテイクアウトを始めるようになった。  
テイクアウトを用いることで、場所を選ばずにお店の味が楽しめるようになり、
より食事を楽しむ選択肢が広がっていくと考えました。  
そこで、今いる場所から徒歩圏内(半径500m)でテイクアウトをやっているお店を簡単に見つけることが出来るアプリを考えました。
LINEのチャットボットを用いることで、よりスピーディーに、スマートに飲食店検索ができると思い、LINEのMessagingAPIとぐるなびのレストラン検索APIを用いアプリを作成しました。

 ##  使用言語、フレームワーク、データベース
 ・Ruby  
 ・Ruby on Rails  
 ・PostgreSQL  
 ・heroku  
 
 ## 説明
 <image src="https://user-images.githubusercontent.com/67094874/91021050-2f9e2980-e62e-11ea-84d8-301c6b3db5b0.png" width="35%">
 
 LINEの位置情報を送ると、その場所から半径500mにあるテイクアウト可の飲食店の情報を取得します。その中からランダムで１件の飲食店情報をレスポンスします。  
 表示項目は、店舗画像、店名、カテゴリ、住所、営業時間、お店のPR  
 下部の「WEBSITE」をタップすると、ぐるなびのお店のページに飛ぶようになってます。
 
 ## 今後の修正点
 ・現在地のみの検索なので、場所を指定した検索を実装する。  
 ・キーワード検索やジャンルを指定しての検索を可能にする。  
 ・テイクアウト可能な店舗がない場合は、検索範囲を広げる機能を実装する。  
