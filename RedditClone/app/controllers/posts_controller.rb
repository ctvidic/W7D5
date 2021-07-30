
class Posts<Controller < ApplicationController
    
    def new
        @post = Post.new
        render :new
    end

    def create
        @post = Post.new(post_params)
        @post.sub_id = params[:sub_id]
        @post.author_id = current_user.id

        if @post.save!
            redirect_to sub_post_url(@post)
        else
            flash.now[:errors] = ['Invalid post!']
            render :new
        end
    end

    def edit
        render :edit
    end

    def update
        @post = Post.find_by(id: params[:id])
        if @post.update(post_params)
            redirect_to sub_post_url(@post)
        else
            flash.now[:errors] = ['Invalid post!']
            render :edit
        end
    end

    def destroy
        @post = Post.find_by(id: params[:id])
        @post.destroy
        redirect_to sub_url(params[:sub_id])
    end

    protected

    def post_params
        params.require(:post).permit(:title, :url, :content)
    end


end