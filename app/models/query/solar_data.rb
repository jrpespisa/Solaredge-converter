class SolarData
  attr_reader :solar_total
  def initialize(start_date, end_date)
    @key = ENV["API_KEY"]
    @uri = URI("https://monitoringapi.solaredge.com/site/171384/energy?timeUnit=DAY&endDate=#{end_date}&startDate=#{start_date}&api_key=#{@key}")
    @response = Net::HTTP.get_response(@uri)
    @info = JSON.parse(@response.body)
    energy_dates = @info["energy"]["values"]
    @solar_total = energy_dates.map { |date| date["value"] }.reduce(:+)
  end
end
