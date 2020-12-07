class UsersController < ApplicationController
  def new
    @user = User.new
    
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Yay! #{@user.username} you are signed up"
      redirect_to articles_path
    else
      render 'new'
    end
  end 

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have successfully upated your account"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def show
    @user = User.find(params[:id])
    @articles = @user.articles.paginate(page: params[:page],per_page:5)
  end

  def index
    @articles = User.paginate(page: params[:page],per_page:5)
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
