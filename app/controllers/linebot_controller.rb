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
          if event.message['text'].include?("何時？")
            response = Time.now
          else
            response = event.message['text']
          end
          message = {
            type: 'text',
            text: response
          }
          client.reply_message(event['replyToken'], message)
        when Line::Bot::Event::MessageType::Location
          lat = event.message['latitude'].to_s
          lon = event.message['longitude'].to_s
          key_id = ENV["ACCESS_KEY"]
          url = "https://api.gnavi.co.jp/RestSearchAPI/v3/?keyid=" + key_id + "&latitude=" + lat + "&longitude=" + lon + "&takeout=1&hit_per_page=3"
          json = JSON.parse( open(url).read )            #ぐるなびAPIから取得したJSONを展開する
          shops = json["rest"]
          shop = shops.sample                   #ランダムで一つ選ぶ
          name = shop["name"]
          shop_url = shop["url_mobile"]
          category = shop["category"]
          image = shop["image_url"]["shop_image1"]
          address = shop["address"]
          pr = shop["pr"]["pr_long"]
          price = shop["budget"]
          responce = "[店名]" + name + "\n" + image + "\n" + pr + "\n" + shop_url
          message = {
            type: 'text',
            text: responce
          }
          client.reply_message(event['replyToken'], message)
        end
      end
    }

    head :ok
  end
end
