# Search Controller
class SearchesController < ApplicationController
  before_action :authenticate_user! # must be logged in

  def index
    @search = current_user.searches
  end

  def new
    @search = current_user.searches.build
  end

  def create
    @search = current_user.searches.build(search_params)

    if @search.save

      # Call API lib
      indeed_service = IndeedService.new(Rails.application.secrets.indeed_api, request.env)

      indeed_service.execute(@search.job1, @search.job2, @search.location)

      result_exists = IndeedResult.find_by(search_id: @search)

      if result_exists
        flash[:success] = 'Search updated!'

        result_exists.update(
          score: indeed_service.response['score'],
          job_total_1: indeed_service.response['job1Total'],
          job_total_2: indeed_service.response['job2Total'],
          job_raw_1: indeed_service.response['job1Raw'],
          job_raw_2: indeed_service.response['job2Raw'],
          job_listing_1: 'temp',
          job_listing_2: 'temp2'
        )
      else
        flash[:success] = 'New search created!'

        IndeedResult.create(
          score: indeed_service.response['score'],
          job_total_1: indeed_service.response['job1Total'],
          job_total_2: indeed_service.response['job2Total'],
          job_raw_1: indeed_service.response['job1Raw'],
          job_raw_2: indeed_service.response['job2Raw'],
          job_listing_1: 'temp',
          job_listing_2: 'temp2',
          search_id: @search.id
        )
      end

      redirect_to indeed_results_path
    else
      flash[:error] = 'Search had a problem saving to the database'
      render 'new'
    end
  end

  def show
    @search = current_user.searches.find(params[:id])
    @indeed = IndeedResult.find(@search)
  end

  def edit
    @search = current_user.searches.find(params[:id])
  end

  private

    def search_params
      params.require(:search).permit(:job1, :job2, :location, :user_id)
    end
end
