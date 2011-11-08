class HomeController < ApplicationController
  def index
  end

  def about
  end

  def callback
    redirect_to "isafeplayer://callback?#{params.to_query}"
  end
end
