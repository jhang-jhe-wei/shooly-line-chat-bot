class WeatherController < ApplicationController
  # require "net/http"
  # require "JSON"
  # require "date"

  # def show
  #   uri = URI("https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-D0047-091?Authorization=CWB-583F2494-D964-4D6F-9F4F-71151DE1529A&elementName=WeatherDescription&fbclid=IwAR2hvYZDDkXSFVhm1ft02tgfiSHrapJdQyzGCwRWzs0kGH1MIAzHvZwAAuo")
  #   response = Net::HTTP.get(uri).force_encoding("UTF-8") # => String
  #   s = JSON.parse response
  #   # t = DateTime.parse @date
  #   value = ""
  #   s["records"]["locations"][0]["location"].each do |item|
  #     if item["locationName"] == @user.location2
  #       item["weatherElement"][0]["time"].each do |element|
  #         if element["startTime"].== @date.strftime("%Y-%m-%d %I:%M:%S")
  #           value = element["elementValue"][0]["value"]
  #         end
  #       end
  #     end
  #   end
  #   @str = value
  #   value.split("。").each do |item|
  #     if item.include?("降雨機率")
  #       value = item.delete("降雨機率 ").delete("%").to_i
  #       if value <= 10
  #         @str = "喔嗨呦，#{@date.strftime("%Y-%m-%d ")}的天氣晴，降雨機率#{value}%，很適合清洗水塔、洗冷氣室外機以及一般水電修繕唷～"
  #       elsif value <= 20
  #         @str = "喔嗨呦，#{@date.strftime("%Y-%m-%d ")}的天氣晴，降雨機率#{value}%，很適合清洗水塔、洗冷氣室外機以及一般水電修繕唷～"
  #       elsif value <= 30
  #         @str = "喔嗨呦，#{@date.strftime("%Y-%m-%d ")}的天氣晴，降雨機率#{value}%，很適合清洗水塔、洗冷氣室外機以及一般水電修繕唷～"
  #       elsif value <= 40
  #         @str = "喔嗨呦，#{@date.strftime("%Y-%m-%d ")}可能會下雨，降雨機率#{value}%，出門請記得帶雨傘，建議不要從事戶外修繕工作"
  #       elsif value <= 50
  #         @str = "喔嗨呦，#{@date.strftime("%Y-%m-%d ")}可能會下雨，降雨機率#{value}%，出門請記得帶雨傘，建議不要從事戶外修繕工作"
  #       elsif value <= 60
  #         @str = "喔嗨呦，#{@date.strftime("%Y-%m-%d ")}有很大的機會會下雨，降雨機率#{value}%，雨勢偏大，出門請小心道路安全，今天適合檢查室內漏水以及屋內滲水情形！但是建議不要從事戶外修繕工作以及戶外配電工作"
  #       elsif value <= 70
  #         @str = "喔嗨呦，#{@date.strftime("%Y-%m-%d ")}有很大的機會會下雨，降雨機率#{value}%，雨勢偏大，出門修繕請小心道路安全，今天適合檢查室內漏水以及屋內滲水情形！但是建議不要從事戶外修繕工作以及戶外配電工作"
  #       elsif value <= 80
  #         @str = "喔嗨呦，#{@date.strftime("%Y-%m-%d ")}有很大的機會會下雨，降雨機率#{value}%，雨勢偏大，出門修繕請小心道路安全，今天適合檢查室內漏水以及屋內滲水情形！但是建議不要從事戶外修繕工作以及戶外配電工作"
  #       elsif value <= 90
  #         @str = "喔嗨呦，#{@date.strftime("%Y-%m-%d ")}有很大的機會會下雨，降雨機率#{value}%，雨勢偏大，出門修繕請小心道路安全，今天適合檢查室內漏水以及屋內滲水情形！但是建議不要從事戶外修繕工作以及戶外配電工作"
  #       else
  #         @str = "喔嗨呦，#{@date.strftime("%Y-%m-%d ")}有很大的機會會下雨，降雨機率#{value}%，雨勢偏大，出門修繕請小心道路安全，今天適合檢查室內漏水以及屋內滲水情形！但是建議不要從事戶外修繕工作以及戶外配電工作"
  #       end
  #     end
  #   end
  # end
end
