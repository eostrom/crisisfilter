class ReportsController < ApplicationController

  before_filter :find_report, :except => [:index]

  REPORTS_PER_PAGE = 20 # should be moved into model

  def index
    refreshed = Report.refresh_if_needed
    flash.now[:refresh] = "#{refreshed} new tweets" if refreshed
    
    # Search defaults
    params[:search]                ||= {}
    params[:search][:content_like] ||= "Haiti"
    params[:search][:order]        ||= :descend_by_upvotes
        
    @search  = Report.search(:content_like => params[:search][:content_like],
                             :order        => params[:search][:order])
    @reports = @search.paginate(:page => params[:page],
                                :per_page => REPORTS_PER_PAGE)
                                
    respond_to do |format|
      format.html
      format.xml  { render :xml => @reports }
    end
  end

  def upvote
    @report.increment!(:upvotes)
    flash[:notice] = "upvoted: #{@report.content}"
    redirect_to reports_path
  end

  def downvote
    @report.increment!(:downvotes)
    flash[:notice] = "downvoted: #{@report.content}"
    redirect_to reports_path
  end

  private

  def find_report
    @report = Report.find(params[:id])
  end

end
