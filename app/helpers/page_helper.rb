module PageHelper
  def display_images(post)  
    unless post["thumbnail"]["image_url"].nil? 
      image_tag(post["screenshot_url"]["300px"], class: "activator" ) 
    else
      image_tag("/default.jpg", class: "activator")
     end    
  end

  def sort_posts(posts)
    if $redis.get(:sort_preference) == "comments"
      posts.sort_by{ |k| k["comments_count"] }.reverse
    else
      posts.sort_by{ |k| k["votes_count"] }.reverse
    end
  end

  def post_limit
    n = $redis.get(:post_limit)
    (n.empty? || n.nil?) ? 4 : n.to_i
  end

  def sort_preference
    ($redis.get(:sort_preference) == "comments") ? "comments" : "votes"
  end
end
