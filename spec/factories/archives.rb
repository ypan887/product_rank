fake_post = {"day"=> "#{Date.today.prev_day}",
     "created_at"=>"2016-05-10T00:00:10.000-07:00",
     "tagline" => "this is a test product hunt",
     "name" => "test product",
     "thumbnail" => "",
     "category_id"=>3,
     "votes_count"=>14,
     "comments_count"=>1,
     "discussion_url"=>
      "some_url"}

FactoryGirl.define do
  factory :archive do
    date { Date.today.prev_day }
    posts { [fake_post] * 2 }
  end
end
