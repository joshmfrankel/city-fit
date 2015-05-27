
class MeetupService
  attr_reader :response

  @@url = 'https://api.meetup.com/find/groups'

  def initialize(meetup_interests, location)
    # Split into array, remove leading/ending spaces, change empty spaces to + signs
    @meetup_interests = meetup_interests.split(',').map{ |x| x.squish.gsub(" ", "+") }
  end

  def execute

    require 'json'

    response = Hash.new

    #Rails.application.secrets.meetup_api = ''

    @meetup_interests.each do |interest|

      request = HTTParty.get("#{@@url}?sign=true&key=#{Rails.application.secrets.meetup_api}&photo-host=public&location=30606&text=#{interest.squish}&radius=25")

      json = JSON.parse(request.body)

      # There was an api error
      # if (json['errors'].nil?)
      #   return nil
      # end

      # Map the important results to the response hash
      response[interest] = json.map{ |group| [group['score'], group['name'], group['link'], group['members']] }

    end

    response
  end

end
