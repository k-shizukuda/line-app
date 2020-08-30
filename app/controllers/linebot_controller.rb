class LinebotController < ApplicationController
  require 'line/bot'  # gem 'line-bot-api'
  require 'open-uri'
  # callbackアクションのCSRFトークン認証を無効
  protect_from_forgery :except => [:callback]

  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
  end

  def callback
    body = request.body.read

    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless client.validate_signature(body, signature)
      head :bad_request
    end

    events = client.parse_events_from(body)

    events.each { |event|
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          message = {
            type: 'text',
            text: "位置情報を送ってください、\nテイクアウトできるお店探しますよ"
          }
          client.reply_message(event['replyToken'],message)
        when Line::Bot::Event::MessageType::Location
          lat = event.message['latitude'].to_s
          lon = event.message['longitude'].to_s
          key_id = ENV["ACCESS_KEY"]             #ぐるなびのアクセスキー
          url = "https://api.gnavi.co.jp/RestSearchAPI/v3/?keyid=" + key_id + "&latitude=" + lat + "&longitude=" + lon + "&takeout=1&hit_per_page=10"
          begin
            message = "このお店はいかがでしょう？"
            data = open(url).read               #ぐるなびからデータを取得
            res_message(event,data,message)
          rescue                                #飲食店を見つけられなかった場合の処理
            url += "&range=3"                   #検索の範囲を半径1000Mに変更
            begin
              message = "少し遠いけどいかがでしょう？"
              data = open(url).read
              res_message(event,data,message)
            rescue                              #検索範囲を広げても見つけられなかった場合の処理
              message = {
                  type: "text",
                  text: "テイクアウトのできるお店を見つけることができませんでした"
              }
              client.reply_message(event['replyToken'],message)
            end
          end
        end
      end
    }

    head :ok
  end
  
  def res_message(event,data, message)
    json = JSON.parse(data)            #ぐるなびAPIから取得したJSONを展開する
    shops = json["rest"]
    if shops.length > 5                         #検索結果が５件より多かった場合は、その中から５件選ぶ
      shops = shops.sample(5)                   #ランダムで選ぶ
    end
    contents = []
    shops.each do |shop|
      contents << make_content(shop)             #取得した飲食店の情報をbubbleタイプで加える
    end
    
    client.reply_message(event['replyToken'], [{
      type: "text",
      text: message
    }, {
      type: "flex",
      altText: "flex message",
      contents: {
        type: "carousel",
        contents: contents
      }
      }]
    )
  end

  def make_content(shop)          #飲食店の情報をbubbleタイプで作成する
    name = shop["name"]
    shop_url = shop["url_mobile"]
    category = shop["category"]
    image = shop["image_url"]["shop_image1"]
    address = shop["address"]
    pr = shop["pr"]["pr_long"]
    pr_short = shop["pr"]["pr_short"]
    price = shop["budget"]
    open_time = shop["opentime"]
    tel = shop["tel"]
    content = {
      type: "bubble",
      hero: {
        type: "image",
        url: image,
        size: "full",
        aspectRatio: "20:13",
        aspectMode: "cover",
        action: {
          type: "uri",
          uri: shop_url
        }
      },
      body: {
        type: "box",
        layout: "vertical",
        contents: [
          {
            type: "text",
            text: name,
            weight: "bold",
            size: "xl"
          },
          {
            type: "box",
            layout: "vertical",
            margin: "lg",
            spacing: "sm",
            contents: [
              {
                type: "box",
                layout: "baseline",
                spacing: "sm",
                contents: [
                  {
                    type: "text",
                    text: category,
                    wrap: true,
                    size: "md",
                    flex: 5
                  }
                ]
              },
              {
                type: "box",
                layout: "baseline",
                spacing: "sm",
                contents: [
                  {
                    type: "text",
                    text: "Place",
                    color: "#aaaaaa",
                    size: "sm",
                    flex: 1
                  },
                  {
                    type: "text",
                    text: address,
                    wrap: true,
                    color: "#666666",
                    size: "sm",
                    flex: 5
                  }
                ]
              },
              {
                type: "box",
                layout: "baseline",
                spacing: "sm",
                contents: [
                  {
                    type: "text",
                    text: "Time",
                    color: "#aaaaaa",
                    size: "sm",
                    flex: 1
                  },
                  {
                    type: "text",
                    text: open_time,
                    wrap: true,
                    color: "#666666",
                    size: "sm",
                    flex: 5
                  }
                ]
              },
              {
                type: "box",
                layout: "vertical",
                contents: [
                  type: "text",
                  text: pr_short,
                  size: "sm",
                  wrap: true
                ]
              }
            ]
          }
        ]
      },
      footer: {
        type: "box",
        layout: "vertical",
        spacing: "sm",
        contents: [
          {
            type: "button",
            style: "link",
            height: "sm",
            action: {
              type: "uri",
              label: "WEBSITE",
              uri: shop_url
            }
          },
          {
            type: "spacer",
            size: "sm"
          }
        ],
        # spacing: "sm",
        paddingAll: "13px"
      }
    }
  end
end
