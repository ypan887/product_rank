FactoryGirl.define do
  factory :archive do
    date { Date.today.prev_day }
    posts { [{"day"=> "#{Date.today.prev_day}",
     "created_at"=>"2016-05-10T00:00:10.000-07:00",
     "tagline" => "this is a test product hunt",
     "name" => "test product",
     "thumbnail" => "",
     "category_id"=>3,
     "votes_count"=>14,
     "comments_count"=>1,
     "discussion_url"=>
      "https://www.producthunt.com/podcasts/hustle-41-hiring-an-agency-with-aaron-o-hearn?utm_campaign=producthunt-api&utm_medium=api&utm_source=Application%3A+product+rank+%28ID%3A+2655%29"}] }
  end
end
