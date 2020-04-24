class SessionsController < ApplicationController
  # ログアウト
  def destroy
    session[:keep_signed_out] = true
  end

  def after_destroy_user_session_for(resource)
    root_path
  end
end
