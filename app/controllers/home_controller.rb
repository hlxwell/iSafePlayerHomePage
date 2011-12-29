class HomeController < ApplicationController
  respond_to :html

  def index
  end

  def about
  end

  def callback
    redirect_to "isafeplayer://callback?#{params.to_query}"
  end

  def facebook_callback
    render :text => request.env['omniauth.auth'].inspect
  end

  def callback_failure
  end
end
