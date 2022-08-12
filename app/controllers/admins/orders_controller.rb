module Admins
  class OrdersController < ApplicationController
    def index
      @orders = Order.all.includes(:reward)
    end

    def show
      @orders = Order.where(employee_id: params[:id]).includes(:reward, :employee)
    end
  end
end
