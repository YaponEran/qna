class RewardsController < ApplicationController
  before_action :authenticate_user!, only: :index
  
  authorize_resource

  def index
    @rewards = current_user.rewards
  end
end
