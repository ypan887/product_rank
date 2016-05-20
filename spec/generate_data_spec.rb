require 'rails_helper'
require 'generate_data'

describe GenerateData do 
  describe "#get_skimed_data" do
    it "get skimed posts data group by date upto x days" do
      posts = GenerateData.new.get_skimed_data("2")
      expect(posts.size).to eq(2)
    end
  end
end