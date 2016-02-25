class SolarData
  def initialize
    @key = ENV["API_KEY"]
    @uri = URI("https://monitoringapi.solaredge.com/site/171384/energy?timeUnit=DAY&endDate=2016-02-07&startDate=2016-02-01&api_key=#{@key}")
    @response = Net::HTTP.get_response(@uri)
    @info = JSON.parse(@response.body)
    binding.pry
  end
end
