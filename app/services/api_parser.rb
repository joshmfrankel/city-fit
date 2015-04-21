# Base Class for api requests
class ApiParser
  attr_reader :type, :request

  def initialize(type, request)
    @type    = type
    @request = request
  end
end
