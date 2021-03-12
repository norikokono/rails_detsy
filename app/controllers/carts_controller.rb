class CartsController < ApplicationController

    def show
      @cart = current_cart
    end

    def add_to_cart
        current_cart.add_item(params[:product_id])
        # redirect to shopping cart or whereever
    end
end


