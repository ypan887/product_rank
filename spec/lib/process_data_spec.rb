require 'rails_helper'
require 'process_data'

describe ProcessData do 
  let(:processer){ ProcessData.new }

  describe "#fetch_today_posts" do
    before(:each) do
      $redis.flushdb
    end

    it "get today's posts from cache if it is already in the cache" do
      $redis.set(:current, [{ "posts" => [] }])
      expect(processer.fetch_today_posts).to_not be_empty
    end

    it "call #cache_posts to get posts" do
      allow(processer).to receive(:cache_posts).and_return({ "posts" => [] }.to_h)
      processer.fetch_today_posts
      expect(processer).to have_received(:cache_posts)
    end
  end

  describe "#cache_posts" do
    it "return today's posts and store it in redis", :vcr do
      posts = processer.cache_posts
      expect(posts).to_not be_empty
      expect($redis.get(:current)).to match(/category\_id/)
    end
  end

  describe "#process_posts" do
    it "eleminates unwanted keys from raw posts and group the posts by date" do
      raw_posts = JSON.parse(File.read(Rails.root.join("spec", "raw_posts.json")))
      processed_posts = processer.process_posts(raw_posts["posts"])
      expect(processed_posts.values.first.first.keys.sort).to eq(%w[name tagline thumbnail category_id day comments_count created_at discussion_url screenshot_url votes_count].sort)
      expect(processed_posts.keys.first).to eq(raw_posts["posts"].first["day"])
    end
  end

  describe "#get_posts_from_yesterday_to_x_days_ago" do
    let(:days){ 2 }
    it "get posts from yesterday to x days ago in an array" do
      allow_any_instance_of(ProductHunt).to receive(:get_posts_x_days_ago) 
      allow(processer).to receive(:process_posts).and_return({"2016-07-03"=>[{"category_id"=>1}]})
      archive_posts = processer.get_posts_from_yesterday_to_x_days_ago(days)
      expect(archive_posts.size).to eq(days)
      expect(processer).to have_received(:process_posts).twice
    end
  end

  describe "#archive_x_days" do
    let(:days){ 1 }
    let(:fake_posts){ [{"2016-07-03"=>[{"category_id"=>1}]}] }
    it "save archive posts to database" do
      allow(processer).to receive(:get_posts_from_yesterday_to_x_days_ago).and_return(fake_posts)
      expect { processer.archive_x_days(days) }.to change{Archive.count}.by(1)
    end
  end
end