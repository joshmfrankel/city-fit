# Indeed service object
class IndeedService
  attr_reader :client, :response

  def initialize(api_key, env)
    @client = Indeed::Client.new api_key
    @env    = env
  end

  def execute(job1, job2, location)
    search1 = format_request(job1, location)
    search2 = format_request(job2, location)

    @response = {
      'score'         => calculate_weighted_score(@client.search(search1)['totalResults'], @client.search(search2)['totalResults']),
      'job_total_1'   => @client.search(search1)['totalResults'],
      'job_total_2'   => @client.search(search2)['totalResults'],
      'job_raw_1'     => @client.search(search1),
      'job_raw_2'     => @client.search(search2),
      'job_listing_1' => 'temp',
      'job_listing_2' => 'temp'
    }
  end

  private

    def format_request(job, location)
      return {
        :q => job,
        :l => location,
        :userip => @env['HTTP_X_FORWARDED_FOR'],
        :useragent => @env['HTTP_USER_AGENT'],
        :latlong => 1
      }
    end

    def format_listing(raw)

    end

    # Weighted formula to allow for job importance slider
    def calculate_weighted_score(job_total_1, job_total_2)

      job_score_1 = calculate_score(job_total_1)
      job_score_2 = calculate_score(job_total_2)
      weight      = 50

      total = ((job_score_1 / 100.0) * weight) + ((job_score_2 / 100.0) * weight)
    end

    # @source http://jobsearch.about.com/b/2013/08/18/the-number-of-job-applications-per-opening.htm
    #
    # 5% chance of getting an interview from an application
    #
    # Scale
    # 0 = 0
    # 1-4 = 5
    # 5-9 = 10
    # 10-19 = 20
    # 20-39 = 30
    # 40-59 = 40
    # 60-79 = 50
    # 80-99 = 60
    # 100-119 = 80
    # 120+ = 100
    def calculate_score(job_total)
      case job_total
        when 0 then 0
        when 1..4 then 5
        when 5..9 then 10
        when 10..19 then 20
        when 20..39 then 30
        when 40..59 then 40
        when 60..79 then 50
        when 80..99 then 60
        when 100..119 then 80
        else 100
      end
    end
end
