class SessionsController < ApplicationController

  def new
  end

  def create
     if user = User.authenticate_with_credentials(params[:sessions][:email], params[:sessions][:password])
       # Save the user id inside the browser cookie.
       session[:user_id] = user.id
       redirect_to '/'
     else
     # If user's login doesn't work, send them back to the login form.
       redirect_to '/sessions/new'
     end
   end

   def destroy
     session[:user_id] = nil
     redirect_to '/'
   end

end
