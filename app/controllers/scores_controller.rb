class ScoresController < ApplicationController
  def show
    find_score_and_check_if_current_user_is_owner
    unless performed?
      render 'scores/show'
    end
  end
  
  def new
    check_if_logged_in
    unless performed?
      @score = Score.new
      @score.owner_id = current_user.id
      @score.save
      redirect_to @score
    end
  end
  
  def update
    find_score_and_check_if_current_user_is_owner
    unless performed?
      @score.update_attributes params[:score]
      @score.generate_output
      render :template => 'scores/update'
    end
  end
  
  def destroy
    find_score_and_check_if_current_user_is_owner
    unless performed?
      @score.update_attributes :trashed => true 
      flash[:notice] = "Successfully deleted score."
      redirect_to scores_path
    end
  end

  def index
    check_if_logged_in
    unless performed?
      @scores = Score.find_all_by_owner_id_and_trashed User.first.id, false
    end
  end

  private

  def find_score_and_check_if_current_user_is_owner
    check_if_logged_in
    unless performed?
      @score = Score.find params[:id]
      unless @score.owner == current_user
        render :nothing => true, :status => 403
      end
    end   
  end

end
