class TrashesController < ApplicationController

  def index
    find_all_trashed_scores_belonging_to_current_user
  end

  def update
    find_score
    check_if_current_user_is_owner
    unless performed?
      @score.trashed = false
      @score.save
      redirect_to trashes_path
    end
  end

  def destroy
    find_score
    check_if_current_user_is_owner
    unless performed?
      @score.destroy if @score.trashed
      redirect_to trashes_path
    end
  end

  def destroy_all
    find_all_trashed_scores_belonging_to_current_user
    unless performed?
      @scores.each { |s| s.destroy }
      redirect_to trashes_path
    end
  end

  private

  def find_score
    @score = Score.find params[:id]
  end

  def find_all_trashed_scores_belonging_to_current_user
    check_if_logged_in
    unless performed?
      @scores = Score.find_all_by_owner_id_and_trashed current_user.id, true
    end
    #@scores = Score.where({:owner_id => current_user.id}).where({:trashed => true})
  end

  def check_if_current_user_is_owner
    check_if_logged_in
    unless performed? && @score.owner == current_user
      render :nothing => true, :status => 403
    end
  end
end
