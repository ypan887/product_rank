require 'rails_helper'
require 'process_data'

describe ProcessData do 
  let(:data){ ProcessData.new }

  describe "#fetch_today_posts" do
    before(:each) do
      $redis.flushdb
    end

    it "get today's posts from cache if it is already in the cache" do
      $redis.set(:current, [{ "posts" => [] }])
      expect(data.fetch_today_posts).to_not be_empty
    end

    it "call #cache_posts to get posts" do
      allow(data).to receive(:cache_posts).and_return({ "posts" => [] }.to_h)
      data.fetch_today_posts
      expect(data).to have_received(:cache_posts)
    end
  end

  describe "#cache_posts" do
    it "return today's posts and store it in redis", :vcr do
      posts = data.cache_posts
      expect(posts).to_not be_empty
      expect($redis.get(:current)).to match(/category\_id/)
    end
  end

# old
  describe "#get_skimed_data" do
    it "get skimed posts data group by date upto x days" do
      posts = GenerateData.new.get_skimed_data("2")
      expect(posts.size).to eq(2)
      expect(posts.values.first.first.keys.sort).to eq(%w[name tagline thumbnail category_id day comments_count created_at discussion_url screenshot_url votes_count].sort)
    end
  end
end