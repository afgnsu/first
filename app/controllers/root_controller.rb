class RootController < ApplicationController
  def home
    ##### 如果已登入，自動轉到用戶列表
    if current_user
      redirect_to users_path
    end
  end

  def sandbox
  	# session[:our_data] = 1234
  end
end
