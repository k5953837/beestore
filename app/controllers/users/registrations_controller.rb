class Users::RegistrationsController < Devise::RegistrationsController
  def upgrade
  end

  def upgrading
    if current_user.update(is_premium: true)
      redirect_to root_url, notice: 'Congratulation to upgrade user to premium.'
    else
      redirect_to root_url, alert: 'Something went wrong.'
    end
  end
end
