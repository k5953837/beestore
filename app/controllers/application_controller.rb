class ApplicationController < ActionController::Base
  def admin_required
    if !current_user.admin?
      redirect_to "/"
    end
  end
end
