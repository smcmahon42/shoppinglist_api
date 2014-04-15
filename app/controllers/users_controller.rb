class UsersController < ApplicationController

  def index
    render :json => [{ :success => false, :token => form_authenticity_token }]
  end

  def create
    @user = User.new(user_params)
    if@user.save
      render :json => [ :user =>@user, :success => true ]
    else
      render :json => [ :success => false ]
    end
  end 

  def show
    @user = User.find(params[:id])
    @userArray = [ :user => @user, :success => true ]
    render :json => @userArray
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      render :json => [ :user => @user, :success => true ]
    else
      render :json => [ :success => false ]
    end
  end

  def destroy
    @user = User.find(params[:id]).destroy
    render :json => [ :user => @user, :success => true ]
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)  
  end

end
