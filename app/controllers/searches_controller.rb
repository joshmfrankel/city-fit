class SearchesController < ApplicationController
  before_action :authenticate_user! # must be logged in


  def index
    @search = Search.all
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
    @user = User.find(params[:id])
    @search = @user.searches
  end

  def search
    client = Indeed::Client.new Rails.application.secrets.indeed_api

    @result = search_params

    # https://ads.indeed.com/jobroll/xmlfeed
    # params = {
    #     :q => 'Ruby on Rails',
    #     :l => 'Chicago, IL',
    #     :userip => request.env['HTTP_X_FORWARDED_FOR'],
    #     :useragent => request.env["HTTP_USER_AGENT"],
    #     :latlong => 1
    # }

    search1 = {
      :q => search_params['job1'],
      :l => search_params['city'],
      :userip => request.env['HTTP_X_FORWARDED_FOR'],
      :useragent => request.env["HTTP_USER_AGENT"],
      :latlong => 1
    }

    search2 = {
      :q => search_params['job2'],
      :l => search_params['city'],
      :userip => request.env['HTTP_X_FORWARDED_FOR'],
      :useragent => request.env["HTTP_USER_AGENT"],
      :latlong => 1
    }

    @result = {
      :job1 => client.search(search1),
      :job2 => client.search(search2)
    }
  end

  private

    def search_params
      params.require(:search).permit(:job1, :job2, :city, :user_id)
    end
end
