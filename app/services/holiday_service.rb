require 'httparty'
require 'json'

class HolidayService
  def usa_dates
    get_url("US")
  end

  def get_url(url)
    response = HTTParty.get("https://date.nager.at/api/v2/NextPublicHolidays/#{url}")
    parsed = JSON.parse(response.body, symbolize_names: true)
    # require "pry"; binding.pry
  end
end
