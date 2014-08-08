class GoalsController < ApplicationController

  before_filter :ensure_signed_in, except: [:index, :show]

  def index
    @user = User.find(params[:user_id])
    @goals = ((@user == current_user) ? @user.goals : @user.public_goals)
  end

  def show
    @goal = Goal.find(params[:id])
    @user = @goal.user

    if @goal.public || current_user == @user
      render :show
    else
      flash.now[:errors] = ["You can only view these goals"]
      redirect_to goals_url(@user)
    end
  end

  def new
    @goal = Goal.new
  end

  def create
    @goal = current_user.goals.new(goal_params)
    if @goal.save
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def edit
    @goal = Goal.find(params[:id])
  end

  def update
    @goal = Goal.find(params[:id])

    if @goal.update(goal_params)
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :edit
    end
  end

  def destroy
    @goal = Goal.find(params[:id]).destroy
    flash[:errors] = ["Goal to \"#{ @goal.title }\" was successfully deleted."]

    redirect_to user_goals_url(@goal.user_id)
  end

  private

  def goal_params
    params.require(:goal).permit(:title, :content, :public, :completed)
  end
end
