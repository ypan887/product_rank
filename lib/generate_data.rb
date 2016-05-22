require 'product_hunt'

class GenerateData
  def get_skimed_data(days)
    posts = (1..days.to_i).inject([]){|posts, day| posts << ProductHunt.new.get_posts_x_days_ago("#{day}")["posts"]; posts}
    skim_posts_by_date = process_data(posts.flatten)
  end

  def process_data(data)
    skim_data = trim_data(data)
    group_data(skim_data)
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