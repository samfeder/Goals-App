class GoalsController < ApplicationController

  before_filter :ensure_signed_in

  def index
    @user = User.find(params[:id])
    @goals = ((@user == current_user) ? @user.goal : @user.public_goals)
  end

  def show
    @goal = Goal.find(params[:id]).include(:user)
    if @goal.public
      render :show
    else
      flash.now[:errors] = ["You can only view these goals"] #will this show? Need now?
      redirect_to goals_url(@goal.user)
    end
  end

  def new
    @goal = Goal.new
  end

  def create
    @goal = current_user.goals.new(goal_params)
    if @goal.save
      render :show
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
      render :show
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :edit
    end
  end

  def destroy
    @goal = Goal.find(params[:id]).destroy
    flash[:errors] = ["#{ @goal.title } was successfully deleted."]

    redirect_to user_goals_url(@goal.user_id)
  end

  private

  def goal_params
    params.require(:goal).permit(:title, :content, :public)
  end
end
