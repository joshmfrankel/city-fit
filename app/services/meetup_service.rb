
class MeetupService
  attr_reader :response

  @@url = 'https://api.meetup.com/find/groups'

  def initialize(meetup_interests, location)
    # Split into array, remove leading/ending spaces, change empty spaces to + signs
    @meetup_interests = meetup_interests.split(',').map{ |x| x.gsub(" ", "+").squish }
    @location = location
  end

  def execute

    require 'json'

    response = []

    @meetup_interests.each do |interest|

      request = HTTParty.get("#{@@url}?sign=true&key=#{Rails.application.secrets.meetup_api}&photo-host=public&location=#{@location}&text=#{interest}&radius=25")

      json = JSON.parse(request.body)

      if request.code != 200
        return nil
      end

      # Format the results from the api
      response.push(format_result(json, interest))

    end

    @response = response
  end

  def format_result(data, name)
    total_members   = 0
    total_meetups   = 0
    total_relevancy = 0
    avg_relevancy   = 0

    data.each do |meetup|
      total_members   += meetup['members']
      total_meetups   += 1
      total_relevancy += meetup['score']
    end

    avg_relevancy = total_relevancy / total_meetups

    [
      'name'          => name,
      'total_members' => total_members,
      'total_meetups' => total_meetups,
      'avg_relevancy' => avg_relevancy,
      'score'         => calculate_score(total_members, total_meetups)
    ]
  end

  def calculate_score(total_members, total_meetups)
    ((calculate_total_member_score(total_members) / 100.0) * 50) + ((calculate_total_meetup_score(total_meetups) / 100.0) * 50)
  end

  # Calculate a base 10 score between 0 and 100
  # http://ruby-doc.org/core-2.0/Enumerable.html#method-i-sort
  def calculate_total_member_score(total_members)
    [total_members.to_s[0...-1].to_i * 10, 0, 100].sort[1]
  end

  def calculate_total_meetup_score(total_meetups)
    case total_meetups
    when 0 then 0
    when 1..3 then 25
    when 4..6 then 50
    when 7..9 then 75
    else 100
    end
  end
end
