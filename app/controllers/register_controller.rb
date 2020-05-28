class RegisterController < ApplicationController
    def load
        render_view
    end

    def register
        @user = User.new(user_params)
        unless(@user.valid?)
            render_view
            return
        end

        unless(User.where(username: @user.username).empty?)
            @user.errors.add(:username, :invalid, message: "is already used.")
            render_view
            return
        end

        if(user_params[:password] != params[:user][:confirm])
            @user.errors.add(:password, "not matches confirmation password.")
            render_view
            return
        end

        @user.save
        redirect_to :login_url
    end

    private def user_params
        params.require(:user).permit(:username, :password)
    end

    private def render_view
        render "register"
    end
end
