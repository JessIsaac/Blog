

class SessionsController < ApplicationController
    
        def new
        
        end
        
        def create
            #Dudas
            user =User.find_by(email: params[:session][:email].downcase)
            #Verify if the email is a valid email
            if user && user.authenticate(params[:session][:password])
                session[:user_id] = user.id
                flash[:success] ="Successfully Log In, Welcome to Isaac's Blog"
                redirect_to user_path(user)
            else 
                #what is a model back form
                flash.now[:danger] ="Ups! something is wrong with you log in, please try again"
             
                # this is  not considered a new request because you are render the same html document
                render 'new'
            end
            
        end
        
        def destroy
            session[:user_id] = nil
            flash[:success] = "you have logged out"
            redirect_to root_path
        end
end