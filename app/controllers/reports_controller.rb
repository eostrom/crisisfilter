class ReportsController < ApplicationController

  before_filter :find_report

  REPORTS_PER_PAGE = 20

  def index
    refreshed = Report.refresh_if_needed
    flash.now[:refresh] = "#{refreshed} new tweets" if refreshed

    @reports =
    if params[:query].blank?
      Report.paginate(:order => 'created_at DESC',
                      :page  => params[:page],
                      :per_page => REPORTS_PER_PAGE)
    else
      Report.simple_search_query(params[:query]).paginate(:order => 'created_at DESC',
                                                          :page  => params[:page],
                                                          :per_page => REPORTS_PER_PAGE)
    end

    respond_to do |format|
      format.html
      format.xml  { render :xml => @reports }
    end
    rescue ActiveRecord::StatementInvalid
      flash[:error] = "There is a problem with your query."
      @reports = Report.paginate(:order => 'created_at DESC',
                                 :page  => params[:page],
                                 :per_page => REPORTS_PER_PAGE)
  end

  def filter
    params[:search] ||= {}

    params[:search][:order] ||= :descend_by_upvotes # +++ should be diff up - down
    params[:search][:timeframe] ||= 'hour'
    params[:search][:upvotes_gte] ||= 1 # ??? what's this?

    @search = Report.search(params[:search])
    @reports = @search.paginate(:page => params[:page])
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

  def refresh
    num_records = Report.get_update( "query.yahooapis.com", "/v1/public/yql", {
                                               "q"  => "select * from twitter.search where q='#haiti #need -RT -rt';",
                                               "format" => "xml",
                                               "env" => "store://datatables.org/alltableswithkeys" }
                                             )

    flash[:notice] = "update complete, updated #{num_records}"
    redirect_to reports_path
  end

  private

  def find_report
    @report = Report.find(params[:id]) if params[:id]
  end

end
