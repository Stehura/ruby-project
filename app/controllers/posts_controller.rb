class PostsController < ApplicationController

    def new 
        @post = nil
    end

    def show
        if(Post.exists?(params[:id]))
            @post = Post.find(params[:id])
        else
            render_404
            return    
        end
    end

    def create
        @post = User.find(session[:user_id]).posts.new(post_params)
        unless (@post.valid?)
            render_new
            return
        end
        @post.save
        redirect_to @post
    end

    def all
        @posts = Post.all
    end

    def edit
        @post = Post.find(params[:id])
        if session[:user_id] != @post.user.id
            render_404
            return
        end
    end

    def update
        @post = Post.new(post_params)
        @post.id = params[:id]
        @post.user = User.find(session[:user_id])
        unless (@post.valid?)
            render_update
            return
        end
        Post.update(@post.id, post_params)
        redirect_to show
    end

    def destroy
        Post.delete(params[:id])
        if(post_url(params[:id]) == request.referrer)
            redirect_to :all_posts
        else
            redirect_to request.referrer
        end
    end

    def new_comment
        @comment = nil
        unless(Post.exists?(params[:id]))
            render_404
            return
        end
    end

    def create_comment
        @post = Post.find(params[:id])
        @comment = @post.comments.new(comment_params)
        @comment.user = @post.user
        unless(@comment.valid?)
            render_new_comment
            return
        end
        @comment.save
        redirect_to @post
    end

    def edit_comment
        @comment = Comment.find(params[:comment_id])
        if session[:user_id] != @comment.user.id
            render_404
            return
        end
    end

    def update_comment
        @comment = Comment.new(comment_params)
        @post = Post.find(params[:id])
        @comment = @post.comments.new(comment_params)
        @comment.user = @post.user
        unless(@comment.valid?)
            render_edit_comment
            return
        end
        Comment.update(params[:comment_id], comment_params)
        redirect_to @post
    end

    def destroy_comment
        Comment.delete(params[:comment_id])
        redirect_to request.referrer
    end

    def give_results
        @results = []
        unless(search_params[:keywords].empty?)
            case params[:in]
                when "1" 
                    username_results = find_by_username
                    title_results = find_by_title
                    category_results = find_by_category
                    @results = username_results | title_results | category_results     
                when "2"          
                    @results = find_by_username
                when "3"
                    @results = find_by_title
                else
                    @results = find_by_category
            end
        end
        render_search
    end

    private def search_words
        return "%#{search_params[:keywords]}%"
    end

    private def find_by_category
        return Post.where("lower(category) like lower(?)", search_words).all
    end

    private def find_by_title
        return Post.where("lower(title) like lower(?)", search_words).all
    end
    
    private def find_by_username
        users = User.where("lower(username) like lower(?)", search_words).all
        return Post.where({user_id: users})
    end

    private def post_params
        params.require(:post).permit(:title, :text, :category)
    end

    private def comment_params
        params.require(:comment).permit(:text)
    end

    private def search_params
        params.require(:query).permit(:keywords, :in)
    end

    private def render_new
        render "new"
    end

    private def render_update
        render "edit"
    end

    private def render_new_comment
        render "new_comment"
    end

    private def render_edit_comment
        render "edit_comment"
    end

    private def render_404
        render file: "#{Rails.root}/public/404", layout: false, status: :not_found
    end

    private def render_search
        render "search"
    end
end
