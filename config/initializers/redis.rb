$redis = Redis::Namespace.new("product_rank", :redis => Redis.new)

$redis.flushdb if Rails.env == "test"