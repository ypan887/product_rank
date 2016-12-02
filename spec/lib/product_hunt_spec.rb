require 'rails_helper'
require 'product_hunt'
require 'webmock/rspec'

describe ProductHunt do

  let(:product_hunt){ ProductHunt.new } 

  describe "get_token" do
    it "get token from redis if there is a token key" do
      $redis.set(:token, "fake token")
      expect(product_hunt.get_token).to eq("fake token")
    end

    it "call fetch_token method to get token if no token key in redis", :vcr do
      $redis.flushdb
      allow(product_hunt).to receive(:fetch_token).and_return(true)
      product_hunt.get_token
      expect(product_hunt).to have_received(:fetch_token)
    end
  end

  describe "#fetch_token" do
    it "get access_token from product hunt api and store it in redis", :vcr do
      expect(product_hunt.fetch_token).to be true
      expect($redis.get(:token).length).to eq(64)
    end
  end

  describe "#get_today_posts" do
    let(:posts){ product_hunt.get_today_posts }
    it "get today's posts under the tech category from product hunt api", :vcr do 
      expect(posts).to have_key("posts")
    end

    it "handles wrong access_token", :vcr do
      allow(product_hunt).to receive(:get_token).and_return("")
      expect(posts).to be_nil
    end

    it "cache the etag from response" do
      allow(product_hunt).to receive(:get_token).and_return("")
      stub_request(:get, "https://api.producthunt.com/v1/posts").
      to_return(headers: { Etag: "1" })
      posts
      expect($redis.get(:etag)).to eq("1")
    end

    it "handles 301" do
    end
  end

  describe "#get_posts_x_days_ago" do
    let(:x){ 1 }
    let(:posts){ product_hunt.get_posts_x_days_ago(x) }

    it "get tech posts x days_ago", :vcr do
      response = product_hunt.get_posts_x_days_ago(x)
      posts = JSON.parse(response.body)["posts"]
      expect(response.headers["date"].to_time.to_date.prev_day.strftime('%Y-%m-%d')).to eq posts.first["day"]
      expect(posts.group_by{ |h| h["day"] }.size).to eq x
    end

    it "return nil if x is invalid days " do
      response = product_hunt.get_posts_x_days_ago("-1")
      expect(response).to be_nil
    end
  end
end