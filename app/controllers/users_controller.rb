class UsersController < ApplicationController
  def new
    @user = User.new
    @categories = Category.all
    @types = Type.all
  end

  def create
    @user = User.new(user_params)
    @categories = Category.all
    @types = Type.all
    if @user.save!
      redirect_to root_path,
        :flash => { :success => 'Utilizatorul a fost salvat' }
    else
      render action: 'new'
    end
  end

  private

    def user_params
      params.require(:user)
        .permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end

end
