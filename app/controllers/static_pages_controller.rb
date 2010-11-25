class StaticPagesController < ApplicationController
  def info; end
  def home
    if current_user
      redirect_to scores_path
    end
  end
end
