class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: [ :new, :create ]

  def new
  end

  def create
    @user = User.find_by_email(params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
				sign_in(@user)
        flash[:success] = "歡迎回來，#{@user.name}！"
        #redirect_to @user
        redirect_to posts_path
    else
        flash.now[:error] = "電子信箱或密碼輸入錯誤！"
        render "new"
    end
  end

  def destroy
  	sign_out
  	redirect_to root_path
  end
end
