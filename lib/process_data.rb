require 'product_hunt'
require 'redis_helper'

class ProcessData
  include RedisHelper

  def initialize
    @product_hunt = ProductHunt.new
  end

  def fetch_today_posts
    posts = get_redis(:current)
    posts.nil?? cache_posts : eval(posts)
  end

  def cache_posts
    data = trim_data(@product_hunt.get_today_posts["posts"])
    data.tap{|p| set_redis(:current, trim_data(p)) unless p.nil? }
  end

  def get_posts_from_yesterday_to_x_days_ago(days)
    posts = (1..days.to_i).inject([]){|posts, day| posts << process_posts(@product_hunt.get_posts_x_days_ago(day)); posts}
  end
  
  def process_posts(data)
    trimmed_posts = trim_data(data)
    group_data(trimmed_posts)
  end

  def archive_x_days(day)
    data = get_posts_from_yesterday_to_x_days_ago(day)
    data.each{ |h| Archive.create({date: h.keys.first, posts: h.values.first}) }
  end

  def posts_x_days_ago
  end

private

  def trim_data(data)
    wanted_key = %w[name tagline thumbnail category_id day comments_count created_at discussion_url screenshot_url votes_count]
    data.map{ |h| h.select {|k,v| wanted_key.include?(k) } }
  end

  def group_data(data)
    data.group_by{ |x| x["day"] }
  end
end