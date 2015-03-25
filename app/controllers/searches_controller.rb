class SearchesController < ApplicationController
  def new
    client = Indeed::Client.new Rails.application.secrets.indeed_api

    #https://ads.indeed.com/jobroll/xmlfeed
    params = {
        :q => 'Ruby on Rails',
        :l => 'Chicago, IL',
        :userip => request.env['HTTP_X_FORWARDED_FOR'],
        :useragent => request.env["HTTP_USER_AGENT"]
    }

    @result = client.search(params)
  end
end
