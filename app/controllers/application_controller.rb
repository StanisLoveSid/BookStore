class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include CanCan::ControllerAdditions
  helper_method :current_order

  def current_order
    if !session[:order_id].nil?
      !find_order.in_progress? ? Order.new : find_order
    else
      Order.new
    end
  end

  def find_order
    Order.find(session[:order_id])
  end

  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update) do |user|
      user.permit(:first_name, :email, :password, :current_password)
    end
  end

end
