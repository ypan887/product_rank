class PreferenceController < ApplicationController
  def setting
    $redis.set(:post_limit, preference_params[:post_limit]) if preference_params[:post_limit]
    $redis.set(:sort_preference, preference_params[:sort_preference]) if preference_params[:sort_preference]
    redirect_to root_path
  end

private

  def preference_params
    params.permit(:post_limit, :sort_preference)
  end 
end

