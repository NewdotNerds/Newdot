class WelcomeController < ApplicationController
  def hello
  	if user_signed_in?
  	  redirect_to root_url
  	end
  end
end
