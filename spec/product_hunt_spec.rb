require 'rails_helper'
require 'product_hunt'

describe ProductHunt do 

  describe "#get_token" do
    let(:token_hash){ProductHunt.new.get_token}
    it "get access_token from product hunt api" do
      expect(token_hash).to be_a(String)
    end
  end

  describe "#get_today_posts" do
    let(:token){ ProductHunt.new.get_token}
    it "get today's posts under the tech category from product hunt api" do
      product_hash = ProductHunt.new.get_today_posts( { category:"tech", token: "#{token}"})
      expect(product_hash).to have_key("posts")
    end

    it "cache the etag from response" do
      $redis.flushdb
      product_hash = ProductHunt.new.get_today_posts( { category:"tech", token: "#{token}"})
      expect($redis.get(:etag)).to eq(product_hash.headers["etag"].delete 'W/\"')
    end
  end

  describe "#handling_current_cache" do
    before(:each){ $redis.flushdb }
    it "cached today's new post in redis if there are new posts return from api" do
      obj = ProductHunt.new
      allow(obj).to receive(:get_today_posts).with(an_instance_of(Hash)).and_return({ posts: "" })
      obj.handling_current_cache({})
      expect($redis.get(:current)).to eq( { "posts": "" }.to_s )
    end
  end

  describe "#get_posts_x_days_ago" do
    it "get tech posts x days_ago" do
      response = ProductHunt.new.get_posts_x_days_ago("1")
      expect(response["posts"].first).to include("day" => Date.today.prev_day.to_s)
    end
  end

  describe "#get_posts_after_post_id" do
    it "get tehc posts after paticular post" do
      response = ProductHunt.new.get_posts_after_post_id("63134")
      expect(response["posts"].first["id"]).to be > 63134
    end
  end
end