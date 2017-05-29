class ArticlesController < ApplicationController
    #the before actions has to be in the correct order to avoid issues
    #before_action must be in the order you want to execute them 
    before_action :set_article, only: [:edit,:update,:show,:destroy]
    before_action :require_user, except:[:index, :show]
    before_action :require_same_user, only: [:edit, :update, :destroy]
    
    def index
        #DUDAS
        @articles = Article.paginate(page: params[:page], per_page: 5)
        #DUDAS
    end 
    
    def new
        @article = Article.new
    end
    def create
        
        @article = Article.new(article_params)
        @article.user = User.find(current_user)
        if @article.save
            flash[:success] = "Article was successfully created"
            redirect_to article_path(@article)
        else
            
            render 'new'
        end
    end
    
    def update 
        if @article.update(article_params)
            flash[:success]= "Article Updated Successfully"
            redirect_to article_path(@article)
        else
            render 'edit'
        end
    end
    
    def edit
       
    end
    
    def show
       
    end
    
    def destroy
        @article.destroy
        flash[:danger] = "Article has been deleted"
        redirect_to articles_path
    end
    
    private
    
    def set_article
        @article = Article.find(params[:id])
    end
    def article_params
        params.require(:article).permit(:title, :description, category_ids: [])
    end
    def require_same_user
        if current_user != @article.user and !current_user.admin?
            flash[:danger] = "you can only edit or delete your own articles"
            redirect_to root_path
        end 
    end
end