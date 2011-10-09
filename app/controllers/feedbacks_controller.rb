class FeedbacksController < ApplicationController
  # GET /feedbacks
  # GET /feedbacks.json
  def index
    @feedbacks = Feedback.order("created_at DESC").page(params[:page])
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @feedbacks }
    end
  end

  def new
    @feedback = Feedback.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @feedback }
    end
  end

  def create
    @feedback = Feedback.new(params[:feedback])

    respond_to do |format|
      if @feedback.save
        format.html { redirect_to feedbacks_path, :notice => t('.create_success') }
      else
        format.html { render :action => "new" }
      end
    end
  end

end
