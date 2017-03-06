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

end
