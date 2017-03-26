class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include CanCan::ControllerAdditions
  helper_method :current_order

  def current_order
    if !session[:order_id].nil?
      !find_order.in_progress? && !find_order.filled? ? Order.new(number: number_generator, delivery: find_delivery) : find_order
    else
      Order.new(number: number_generator, delivery: find_delivery)
    end
  end

  def number_generator
    "#N"+Time.now.to_f.to_s[0, 10]
  end

  def find_delivery
    Delivery.find_by(name: "none")
  end

  def find_order
    Order.find(session[:order_id])
  end

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update) do |user|
      user.permit(:first_name, :email, :password, :current_password)
    end
  end

end
