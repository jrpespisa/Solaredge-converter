class SolarData
  def initialize
    @key = ENV["API_KEY"]
    @uri = URI("https://monitoringapi.solaredge.com/site/171384/energy?startDate=2016-02-2&endDate=2016-07-2?api_key=#{@key}")
    # @uri = URI("https://monitoringapi.solaredge.com/equipment/171384/sensors?api_key=#{@key}")
    @response = Net::HTTP.get_response(@uri)
    # @info = JSON.parse(@response.body)
    binding.pry
  end
end
