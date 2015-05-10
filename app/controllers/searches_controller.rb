# Search Controller
class SearchesController < ApplicationController
  before_action :authenticate_user! # must be logged in
  before_action :set_search, only: [:show, :edit, :update, :destroy]
  before_action :authorized_user, only: [:show, :edit, :update, :destroy]

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
      indeed_service.execute(@search.job1, @search.job2, @search.job_scale, @search.location)
      @indeed = @search.create_indeed_result(indeed_service.response)
      #@response = indeed_service.response['job_raw_1']['results']
      #render :text => @response

      flash[:success] = 'New search created!'
      redirect_to @search
    else
      flash[:error] = 'Search had a problem saving to the database'
      render 'new'
    end
  end

  def show
    @indeed = IndeedResult.find_by(search_id: @search.id)
  end

  def edit
    render 'new'
  end

  def update

    indeed_service = IndeedService.new(Rails.application.secrets.indeed_api, request.env)
    indeed_service.execute(@search.job1, @search.job2, @search.location)
    @indeed = @search.build_indeed_result(indeed_service.response)

    if @search.update_attributes(search_params)
      if @indeed.update_attributes(indeed_service.response)
        flash[:success] = "Search updated"
        redirect_to @search
      else
        render 'edit'
      end
    else
      render 'edit'
    end
  end

  def destroy
    @search.destroy
    flash[:success] = "Search deleted"
    redirect_to searches_path
  end

  # Compare up to three searches
  def compare
    #https://github.com/superjustin/zip-codes-for-rails
    @compare = Search.limit(3).find(params[:compare])
  end

  private

    def set_search
      @search = Search.find(params[:id])
    end

    def authorized_user
      @search = Search.find(params[:id])
      @user = User.find(@search.user_id)
      redirect_to(root_url) unless current_user?(@user)
    end

    def search_params
      params.require(:search).permit(:job1, :job2, :location, :job_scale, :user_id)
    end
end
