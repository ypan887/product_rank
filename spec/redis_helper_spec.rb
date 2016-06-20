require 'rails_helper'
require 'redis_helper'

describe RedisHelper do 
  include ActiveSupport::Testing::TimeHelpers
  let(:dummy_class) { Class.new { include RedisHelper } }

  describe "#get_redis" do
    it "took a key as argument and, get value from redis with the key" do
      $redis.set(:test, 1)

      expect(dummy_class.new.get_redis(:test)).to eq("1")
    end
  end

  describe "#expire_token" do
    it "set a expiration time on token" do
      $redis.set(:token, 1)

      expect(dummy_class.new.expire_token(1)).to be true
    end
  end

  describe "#set_redis" do
    it "took a key and value as argument and set that key/value pair in redis" do
      dummy_class.new.set_redis(:test, 1)
      expect($redis.get(:test)).to eq("1")
    end
  end
end