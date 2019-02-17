class Admin::UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_param)

    if @user.save
      redirect_to admin_user_path(@user), notice: "ユーザ「#{@user.name}」を登録しました。"
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_param)
      redirect_to admin_user_path(@user), notice: "ユーザ「#{@user.name}」を更新しました。"
    else
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path, notice: "ユーザ「#{@user.name}」を削除しました。"
  end

  def index
    @users = User.all
  end

  private

  def user_param
    params.require(:user).permit(:name, :email, :admin,
                                 :password, :password_confirm)
  end
end
