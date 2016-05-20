require 'product_hunt'

class GenerateData
  def get_skimed_data(days)
    response = ProductHunt.new.get_posts_x_days_ago("#{days.to_i+1}")
    id = response["posts"].last["id"].to_i
    posts = ProductHunt.new.get_posts_after_post_id(id)["posts"]
    wanted_key = %w[category_id day comments_count created_at discussion_url screenshort_url votes_count]
    skim_posts = posts.map{ |h| h.select {|k,v| wanted_key.include?(k) } }

    skim_posts_by_date = skim_posts.group_by{ |x| x["day"] }
  end
end