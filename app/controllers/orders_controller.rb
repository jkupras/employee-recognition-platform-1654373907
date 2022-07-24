class OrdersController < ApplicationController
  before_action :authenticate_employee!

  def create
    order = Order.new(order_params)
    order.employee = current_employee
    order.amount = Reward.find(params[:reward_id]).price
    order.employee.available_points -= order.amount

    if order.save
      order.employee.save!
      redirect_to rewards_path, notice: 'The reward has been bought'
    else
      redirect_to rewards_path, notice: order.errors.full_messages
    end
  end

  def my_rewards
    @my_rewards = current_employee.orders.includes(:reward)
  end

  private

  def order_params
    params.permit(:reward_id)
  end
end
