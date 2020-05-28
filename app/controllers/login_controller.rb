class LoginController < ApplicationController
    def load
        render_view
    end

    def validate
        @user = User.new(user_params)
        unless(@user.valid?)
            render_view
            return
        end
        
        user = User.where({username: @user.username, password: @user.password}).first
        unless(user.nil?)
            session[:user_id] = user.id
            @user = user
            redirect_to :main
        else
            @user.errors.add(:username, :invalid, message: "or password is not valid.")
            render_view
        end
    end

    def logout
        session[:user_id] = nil
        redirect_to :login_url
    end

    private def user_params
        params.require(:user).permit(:username, :password)
    end

    private def render_view
        render "login"
    end
end
