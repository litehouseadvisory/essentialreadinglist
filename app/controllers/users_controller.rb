class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :show, :destroy, :following, :followers]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  
  def new
    @user = User.new
  end
  
  def index
    @users = User.paginate(page: params[:page], :per_page => 10)
  end
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page],:per_page => 5)
    @books = @user.books.paginate(page: params[:page], :per_page => 10)
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Gwerl!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
    
  end
  
  def update
    
    if @user.update_attributes(user_params)
      flash[:success] =  "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    user = User.find(params[:id])
    if user.books.empty?
      user.destroy
      flash[:success] = "User deleted."
      redirect_to users_url
    else
      flash[:error] = "This user has added books to the GWERL and cannot be deleted."
      redirect_to :back
    end
  end
  
  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users= @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end
  
  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
  
  
  private
  
  def user_params
    params.require(:user).permit( :name, :email, :password, :password_confirmation )
  end
  
  # before filters
  
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
  
  def admin_user
    redirect_to(root-url) unless current_user.admin?
  end
  
  
end
