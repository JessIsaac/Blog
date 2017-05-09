class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  #the methods created in the aplicationcontroller are available to all the controller
  #but they are not available in the views by default
  # so we need to tell rails that this methods are helper methods
  
  helper_method :current_user,:logged_in?
  
  
  def current_user
    #pipe pipe equals is an IF
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    #return user if there is a user store that's backed by our browser in our session hash
    #if so then find the user in our database based on the user_id
  end
  
  def logged_in?
      !!current_user
  end
  
  def require_user
      if !logged_in?
        flash[:danger] = "You must be logged in to perform that action"
        redirect_to root_path
      end
  end
 
end
