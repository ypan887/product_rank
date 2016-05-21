require 'rails_helper'
require 'generate_data'

describe GenerateData do 
  describe "#get_skimed_data" do
    it "get skimed posts data group by date upto x days" do
      posts = GenerateData.new.get_skimed_data("2")
      expect(posts.size).to eq(2)
      expect(posts.values.first.keys).to eq(%w[name tagline thumbnail category_id day comments_count created_at discussion_url screenshot_url votes_count])
    end
  end
end