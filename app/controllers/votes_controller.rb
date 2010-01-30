class VotesController < ApplicationController
  
  before_filter :find_report, :login_required
  
  def up
    @vote = @report.upvotes.new(:user => current_user)        
    respond_to do |format|
      if @vote.save
        message = "upvoted: #{@report.content}"
        format.html { flash[:notice] = message; redirect_to reports_path }
        format.js   { render :action => "update" } #update.js.rjs
      else
        message = "An error occurred: #{@vote.errors.full_messages.to_sentence}"
        format.html { flash[:error] = message; redirect_to reports_path }
        format.js   { render(:update){ |p| p << "alert('#{message}')"  } }
      end
    end
  end

  def down
    @vote = @report.downvotes.new(:user => current_user)    
    respond_to do |format|
      if @vote.save
        message = "downvoted: #{@report.content}"
        format.html { flash[:notice] = message; redirect_to reports_path }
        format.js   { render :action => "update" } #update.js.rjs
      else
        message = "An error occurred: #{@vote.errors.full_messages.to_sentence}"
        format.html { flash[:error] = message; redirect_to reports_path }
        format.js   { render(:update){ |p| p << "alert('#{message}')"  } }
      end
    end
  end

  private

  def find_report
    @report = Report.find(params[:report_id])
  end
  
end
