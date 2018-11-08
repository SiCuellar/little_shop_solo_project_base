class Admin::UsersController < ApplicationController
  def edit
    render file: 'errors/not_found', status: 404 if current_user.nil?
    if current_user
      @user = current_user
      if current_admin? && params[:slug]
        @user = User.find_by(slug: params[:slug])
        # binding.pry
      elsif current_user && params[:slug] && current_user.slug != params[:slug]
        render file: 'errors/not_found', status: 404
      end
    end
  end

  def update
    @user = User.find_by(slug: params[:slug])
    @user.update(user_params)
      flash[:success] = "User updated"
      redirect_to user_path(@user)
  end

  private

  def user_params
    params.require(:user).permit(:slug)
  end

  def require_admin
    redirect_to root_path unless current_admin?
  end
end
