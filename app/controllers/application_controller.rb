class ApplicationController < ActionController::Base

    private
  
    def current_user
      if session[:user_id].present?
        @current_user ||= User.find session[:user_id]
      end
    end
    helper_method :current_user
  
    def user_signed_in?
      current_user.present?
    end
    helper_method :user_signed_in?
  
    def authenticate_user!
      unless user_signed_in?
        flash[:danger] = "Please, Sign in!"
        redirect_to new_session_path
      end
  end

  def current_cart
    if session[:cart_id]
      @current_cart ||= Cart.find(session[:cart_id])
    end
    if session[:cart_id].nil?
      @current_cart = Cart.create!
      session[:cart_id] = @current_cart.id
    end
    @current_cart
    end 


end