class UsersController < ApplicationController
  before_action :authenticate_user
  skip_before_action :authenticate_user, only: [ :new, :create ]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    #@users = User.all
    #加入分頁
    #@users = User.all.page(params[:page])
    #@users = User.paginate(:page => params[:page], :per_page => 5)
    #@users = User.paginate(:page => params[:page])
    @users = User.page params[:page]
  end

  # GET /users/1
  # GET /users/1.json
  def show
    #加入分頁
    #@posts = @user.posts.page(params[:page])
    #@posts = @user.posts.paginate(:page => params[:page])
    #@posts = current_user.posts.paginate(:page => params[:page])
    #@posts = current_user.posts.page params[:page]
    #@posts = User.posts.page params[:page]
    #@posts = @user.posts.page params[:page]
    @posts = @user.posts.page(params[:page]).order('created_at DESC')

  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(create_params)
    if @user.save
      sign_in(@user)
      flash[:success] = "歡迎光臨，#{@user.name}！"
      redirect_to @user
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if @user.update(update_params)
      flash[:success] = "用戶資料已更新！"
      redirect_to @user
    else
      render action: 'edit'
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def update_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def create_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
