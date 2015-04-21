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
      'score'     => calculate_score(search1, search2),
      'job1Total' => @client.search(search1)['totalResults'],
      'job2Total' => @client.search(search2)['totalResults'],
      'job1Raw'   => @client.search(search1),
      'job2Raw'   => @client.search(search2)
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

    def calculate_score(search1, search2)
      total1    = @client.search(search1)['totalResults']
      total2    = @client.search(search2)['totalResults']
      avg       = (total1 + total2) / 2
      handicap1 = (total1 < 10 ? 1 : 0)
      handicap2 = (total2 < 10 ? 1 : 0)
      score     = avg - (handicap1 * (total2 / 3)) - (handicap2 * (total1 / 3))
    end
end
