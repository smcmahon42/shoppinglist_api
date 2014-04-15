class GroupsController < ApplicationController

  def index
    if !params[:user_id].blank?
      @user = User.find(params[:user_id])
      @selectedGroups = @user.groups
      # render_with_protection @selectedGroups
      render :json => [ @selectedGroups ]
    else
      @group = Group.all.where( :private => false, :limit => 100 ).order("groups.id ASC")
      render :json => [ @group ]
    end
  end


  def create
    @group = Group.new(group_params)
    if@group.save && !params[:user_id].blank?
      @user = User.find(params[:user_id])
      @group.users << @user
      render :json => [ @group ]
    else
      render :json => [ :success => false ]
    end
  end 


  def show
      @group = Group.find(params[:id])
      render :json => [ @group ]
  end


  def update
    @group = Group.find(params[:id])
    if !params[:user_id].blank?
      @user = User.find(params[:user_id])
      @group.users << @user
      render :json => [ @group ]
    elsif @group.update_attributes(group_params)
      render :json => [ @group ]
    else
      render :json => [ :success => false ]
    end
  end


  def destroy
    @group = Group.find(params[:id])
    if !params[:user_id].blank?
      #delete a specific assoc group for a user
      @user = User.find(params[:user_id])
      @user.groups.delete(@group)
      render :json => [ @group ]
    else
      #delete a group all togehter
      @group.users.destroy
      @group.destroy
      render :json => [ @group ]
    end
  end

  private 

  def group_params
     params.require(:group).permit(:group_name, :private)
  end


end
