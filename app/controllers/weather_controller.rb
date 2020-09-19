class WeatherController < ApplicationController
  def show
    @temperature = 29
    @raining_rate = "40%"
  end
end
