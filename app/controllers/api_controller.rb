class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token



  def news

    tweets = Tweet.last(50)
    hash = tweets.map do |t|
    {
      :id => t.id,
      :content => t.content,
      :user_id => t.user_id,
      :like_count => t.likes.count,
      :retweets_count => t.count_rt, #metodo #count_rt en tweet.rb model
      :retweeted_from => (t.rt_ref.nil? ? "" : t.rt_ref)
    }
    end

    render json: hash
  end




  def tweets_by_dates
    date1= Date.parse(params[:date1])
    date2= Date.parse(params[:date2])

    tweets=Tweet.where(created_at: date1..date2)

    hash = tweets.map do |t|
      {
        :id => t.id,
        :content => t.content,
        :user_id => t.user_id,
        :like_count => t.likes.count,
        :retweets_count => t.count_rt, #metodo #count_rt en tweet.rb model
        :retweeted_from => (t.rt_ref.nil? ? "" : t.rt_ref)
      }
      end
  
      render json: hash
  end



  def create_tweet

    user= User.authenticate(params[:email] , params[:password])
    if !user.nil?

      @tweet = Tweet.new(tweet_params)
      @tweet.user = user
      if @tweet.save
        render json: @tweet
      else
        render json: { errors: "error" }
      end
    else
      render json: "credenciales incorrectas"

    end
  end



  private

  def tweet_params
    params.require(:tweet).permit(:content, :user_id)
  end


end
