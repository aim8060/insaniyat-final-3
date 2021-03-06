class PostsController < ApplicationController
  def new
    @user = User.find(params[:id])
  	@post = @user.posts.build
  end

  def makepost
    #@post = Post.new(permit_post)
    #debugger
    @user = User.find(params[:id])
    @post = @user.posts.build(permit_post)
    if @post.save
      respond_to do |format|
        format.html {redirect_to root_path}
        format.json {render json: @post}
      end
    end
  end

  def index
    if params[:id] == 'getmiss'
      @posts = Post.where(:status => 'lost').order("created_at DESC").paginate(page: params[:page], per_page: 9)
    elsif params[:id] == 'getfound'
      @posts = Post.where(:status => 'found').order("created_at DESC").paginate(page: params[:page], per_page: 9)
    else
      @posts = Post.where(:status => 'lost').order("created_at DESC").paginate(page: params[:page], per_page: 9)
    end
    respond_to do |format|
        format.html 
        format.json {render json: @posts}
    end
  end

  def show
    @post = Post.find(params[:id])
  end


  def about
  end
  
  def getDetail
    @post = Post.find(params[:getD]) # file_name is the data key of Ajax request in view

    respond_to do |format|
      format.html 
      format.json { render json: @post }
    end
  end

  def threemissing
    @posts = Post.where(:status => 'lost').limit(3);
    respond_to do |format|
        format.json {render json: @posts}
    end
  end

  def threefound
    @posts = Post.where(:status => 'found').limit(3);
    respond_to do |format|
        format.json {render json: @posts}
    end
  end

  def getallmissing
    @posts = Post.where(:status => 'lost');
    respond_to do |format|
        format.html {redirect_to root_path(@post)}
        format.json {render json: @posts}
    end
  end

  def getallfound
    @posts = Post.where(:status => 'found');
    respond_to do |format|
        format.html {redirect_to root_path(@posts)}
        format.json {render json: @posts}
    end
  end



	private
		def permit_post
			params.require(:post).permit(:status,:requestdate,:place,:city,:relation,:gender,:mentalstatus,:name,:fathername,:age,:clothes,:clothescolor,:description,:image,:user_id)
		end
end