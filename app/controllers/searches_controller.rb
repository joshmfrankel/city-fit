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
      flash[:success] = 'New search saved!'
      redirect_to @search
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
    @search = current_user.searches.find(params[:id])

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

    puts @search.nil?

    # @result = {
    #   "job1" => client.search(search1),
    #   "job2" => client.search(search2)
    # }

    # Save results to result table with reference to the search id
    #puts @result['job1']['totalResults']
    # @search.results.create(
    #   :score => 20,
    #   :job1Total => @result['job1']['totalResults'],
    #   :job2Total => @result['job2']['totalResults']
    # )
    #@search.results.find_or_initialize_by(search_id: params[:id])
    #@search.results.update(:score => 25)
    # @search.results.where(search_id: @search.id).first_or_create

    render 'result'
  end

  private

    def search_params
      params.require(:search).permit(:job1, :job2, :location, :user_id)
    end
end
