class RewardsController < ApplicationController
  before_action :authenticate_employee!

  def index
    @reward = Reward.all
  end

  def show
    @reward = Reward.find(params[:id])
  end
end
