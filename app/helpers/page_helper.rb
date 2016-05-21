module PageHelper
  def display_images(post)  
    unless post["thumbnail"]["image_url"].nil? 
      image_tag(post["screenshot_url"]["300px"], class: "activator" ) 
    else
      image_tag("/default.jpg", class: "activator")
     end    
  end
end
