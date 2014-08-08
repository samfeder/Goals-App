class GoalsController < ApplicationController

  def index
    @user = User.find(param[:id])
    @goals = @user == current_user ? @user.goal : @user.public_goals
    render :show

  end
end
