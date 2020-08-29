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
  
現在、飲食店では売り上げが低迷しており、なんとかしようとテイクアウトを始めるところが増えており、   
少しでも、そんな飲食店の力になりたいとの思いがありました。  
ユーザーにとっても、テイクアウトがより利用しやすくなることで、
場所を選ばずにお店の味が楽しめるようになり、
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
 
 LINEの位置情報を送ると、その場所から半径500mにあるテイクアウト可の飲食店の情報を取得します。  
 その中からランダムで１件の飲食店情報をレスポンスします。  
 表示項目は、店舗画像、店名、カテゴリ、住所、営業時間、お店のPR  
 下部の「WEBSITE」をタップすると、ぐるなびのお店のページに飛ぶようになってます。
 
 ## 　追加機能
 
 半径500mの範囲で飲食店が見つからなかった場合、範囲を1000mに広げて検索する機能を追加しました。  
 それでも見つからなかった場合は、見つからなかったというコメントを返します。
 
 検索結果を最大５件まで表示出来る機能を追加しました。
 取得した情報が５件よりも多い場合は、５件をランダムで表示させます。
 
 # デモ
 LINEの位置情報の機能を用いて、チャットボットに位置情報を送ります。  
 
 <image src="https://user-images.githubusercontent.com/67094874/91172152-aa427400-e716-11ea-8e83-4f323882780b.png" width="35%">
 
 送られた位置情報から半径500m以内にテイクアウトの出来る飲食店があった場合、  
 メッセージと飲食店の情報が送られます。  
 
  <image src="https://user-images.githubusercontent.com/67094874/91172006-78311200-e716-11ea-9c96-6ab4da3ef642.png" width="35%">
 
 送られた位置から500mの範囲でテイクアウトできる飲食店が見つからなかった場合、  
 半径1000mの範囲でもう一度検索をします。
 該当するお店があった場合、「少し遠いけどいかがでしょう？」というメッセージと飲食店の情報が送られます。
 
  <image src="https://user-images.githubusercontent.com/67094874/91172829-d0b4df00-e717-11ea-9995-225e30d5b2ca.png" width="35%">
 
1000mの範囲でも見つからなかった場合は、検索を終わらせメッセージを返します。

<image src="https://user-images.githubusercontent.com/67094874/91173617-102ffb00-e719-11ea-9ccc-fc5d67362c99.png" width="35%">
  
 
 ## 今後の修正点
 ・現在地のみの検索なので、場所を指定した検索を実装する。  
 ・キーワード検索やジャンルを指定しての検索を可能にする。  
 ・テイクアウト可能な店舗がない場合は、検索範囲を広げる機能を実装する。(追加済み)  
 ・複数の飲食店を表示できるようにする。（追加済み）
