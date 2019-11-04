class SessionsController < Devise::SessionsController
  after_action :show_flash, only: :create

  private

  def show_flash
    if current_user.first_name.present? && current_user.last_name.present?
      flash[:notice] = "Hello, #{current_user.first_name} #{current_user.last_name}!"
    else
      flash[:notice] = "Hello, #{current_user.email}!"
    end
  end
end
