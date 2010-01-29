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
    
    # Explicit declaration of searched fields so that users can't hack the search    
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
    message = "upvoted: #{@report.content}"
    respond_to do |format|
      format.html { flash[:notice] = message; redirect_to reports_path }
      format.js   { render(:update){ |page| page.replace "report_#{@report.id}", :partial => @report } }
    end
  end

  def downvote
    @report.increment!(:downvotes)
    message = "downvoted: #{@report.content}"
    respond_to do |format|
      format.html { flash[:notice] = message; redirect_to reports_path }
      format.js   { render(:update){ |page| page.replace "report_#{@report.id}", :partial => @report } }
    end
  end

  private

  def find_report
    @report = Report.find(params[:id])
  end

end
