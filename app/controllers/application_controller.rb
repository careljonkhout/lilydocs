class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :require_https

  def require_https
    if Rails.env.production?
      redirect_to :protocol => 'https://' unless ( request.ssl? || request.path == '/users/confirmation' )
    end
  end

  private

  def check_if_logged_in
    unless current_user
      redirect_to new_user_session_path
    end
  end

  def after_sign_in_path_for(resource_or_scope)
    scores_path
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

  def after_update_path_for(resource_or_scope)
    scores_path
  end
end
