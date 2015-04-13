# Search Controller
class SearchesController < ApplicationController
  before_action :authenticate_user! # must be logged in

  def index
    @search = current_user.searches.includes(:results)
  end

  def new
    @search = current_user.searches.build
  end

  def create
    @search = current_user.searches.build(search_params)

    if @search.save
      flash[:success] = 'New search saved!'
      redirect_to searches_path
    else
      render 'new'
    end
  end

  def show
    @search = current_user.searches.find(params[:id])
  end

  def results
    # Load the api
    client = Indeed::Client.new Rails.application.secrets.indeed_api

    # Get the search data
    @search = current_user.searches.find_by(id: params[:id])

    if @search

      search1 = {
        :q => @search.job1,
        :l => @search.location,
        :userip => request.env['HTTP_X_FORWARDED_FOR'],
        :useragent => request.env['HTTP_USER_AGENT'],
        :latlong => 1
      }

      search2 = {
        :q => @search.job2,
        :l => @search.location,
        :userip => request.env['HTTP_X_FORWARDED_FOR'],
        :useragent => request.env['HTTP_USER_AGENT'],
        :latlong => 1
      }

      @parsed_result = {
        :score => 25,
        :job1Total => client.search(search1)['totalResults'],
        :job2Total => client.search(search2)['totalResults'],
        :raw1 => client.search(search1),
        :raw2 => client.search(search2)
      }

      # Create / Update
      result_exists = Result.find_by(search_id: @search)

      if result_exists
        result_exists.update(
          score: @parsed_result[:score],
          job1Total: @parsed_result[:job1Total],
          job2Total: @parsed_result[:job2Total]
        )
      else
        @search.results.create(
          score: @parsed_result[:score],
          job1Total: @parsed_result[:job1Total],
          job2Total: @parsed_result[:job2Total]
        )
      end

      flash[:success] = 'Successfully calculated a new CityFit Score'
      render 'result'
    else
      flash[:error] = 'Id doesn\'t exist'
      redirect_to searches_path
    end
  end

  private

    def search_params
      params.require(:search).permit(:job1, :job2, :location, :user_id)
    end

    def result_params
      params.require(:result).permit(:score, :job1Total, :job2Total, :search_id)
    end
end
