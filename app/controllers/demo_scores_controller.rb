class DemoScoresController < ApplicationController
  def index
    @score = DemoScore.new
    render 'scores/show'
  end
  
  def create
    @score = DemoScore.new(params[:demo_score])
    @score.generate_output
    render 'scores/update'
  end
end
