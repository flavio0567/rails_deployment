class GroupsController < ApplicationController

  def index
    @groups = Group.all
    # @groups = Group.joins(:user).where(state: current_user.state)
    # @other_events = Event.all.where.not(state: current_user.state)
  end

  def create
    group = Group.new group_params
    unless group.save
      flash[:errors] = group.errors.full_messages
    end
    redirect_to groups_path
  end

  def show
    @group = Group.find(params[:id])
    @user = User.joins(group_id: params[:id])                          
  end

  def edit
    @group = Group.find(params[:id])
  end

  def destroy
    @group = Group.find(params[:group_id])
    @group.destroy
    redirect_to groups_path
  end

  private
    def group_params
      params.permit(:name, :description).merge(user: current_user)
    end
end
