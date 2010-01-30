class ReportsController < ApplicationController

  def index
    refreshed = Report.refresh_if_needed
    flash.now[:refresh] = "#{refreshed} new tweets" if refreshed
    
    # Search defaults
    params[:search]                ||= {}
    params[:search][:content_like] ||= "Haiti"
    params[:search][:order]        ||= :descend_by_upvotes
    
    # Explicit declaration of searched fields so that users can't hack the search    
    @search  = Report.search(:content_like => params[:search][:content_like],
                             :order        => params[:search][:order])
    @reports = @search.paginate(:page => params[:page])
                                
    respond_to do |format|
      format.html
      format.xml  { render :xml => @reports }
    end
  end

end
