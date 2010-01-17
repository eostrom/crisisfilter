class ReportsController < ApplicationController

  before_filter :find_report

  REPORTS_PER_PAGE = 20

  def create
    @report = Report.new(params[:report])
    respond_to do |format|
      if @report.save
        flash[:notice] = 'Report was successfully created.'
        format.html { redirect_to @report }
        format.xml  { render :xml => @report, :status => :created, :location => @report }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @report.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @report.destroy
        flash[:notice] = 'Report was successfully destroyed.'        
        format.html { redirect_to reports_path }
        format.xml  { head :ok }
      else
        flash[:error] = 'Report could not be destroyed.'
        format.html { redirect_to @report }
        format.xml  { head :unprocessable_entity }
      end
    end
  end

  def index
    @reports = Report.paginate(:page => params[:page], :per_page => REPORTS_PER_PAGE)
    respond_to do |format|
      format.html
      format.xml  { render :xml => @reports }
    end
  end

  def edit
  end

  def new
    @report = Report.new
    respond_to do |format|
      format.html
      format.xml  { render :xml => @report }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.xml  { render :xml => @report }
    end
  end

  def update
    respond_to do |format|
      if @report.update_attributes(params[:report])
        flash[:notice] = 'Report was successfully updated.'
        format.html { redirect_to @report }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @report.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update_database
    num_records = ReportsHelper::get_update( "query.yahooapis.com", "/v1/public/yql", { 
                                               "q"  => "select * from twitter.search where q='#haiti #need -RT -rt';",
                                               "format" => "xml",
                                               "env" => "store://datatables.org/alltableswithkeys" }
                                             )
    
    render :text => "update complete, updated #{num_records}", :layout => nil
  end

  private

  def find_report
    @report = Report.find(params[:id]) if params[:id]
  end

end
