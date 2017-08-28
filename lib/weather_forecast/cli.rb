class WeatherForecast::CLI

	def call 
		list_cities
	end

	def list_cities 
		puts "Choose a city to see the current weather forecast:"
		city_menu
	end

	def city_menu
	    puts <<~DOC
		 	1. New York, NY
		 	2. Boston, MA
		 	3. San Francisco, CA
		 	4. Austin, TX 
			5. Seattle, WA
		 	6. Orlando, FL
		 	7. Phoenix, AZ
			8. Washington, D.C.
			9. Denver, CO
		 	10. Hartford, CT
		DOC
		city_url
    end

    def city_url
        input = gets.strip
		@cities = WeatherForecast::Cities.today
		@the_city = @cities[input.to_i-1]
		until input.to_i > 0 && input.to_i < 11
			puts "Please enter a number 1-10"
			input = gets.strip
		end
		if input == "1"
			WeatherForecast::Cities.scrape_newyork
		elsif input == "2"
			WeatherForecast::Cities.scrape_boston
		end

		forecast_type
	end

    def forecast_type
    	puts "Choose a number to see the current forecast:"
    	puts <<~DOC
    	    1. Forecast
    	    2. Temperature
    	    3. High/Low
    	    4. Humidity
    	    5. Sunrise/Sunset
        DOC
        forecast_choice
	end

	def forecast_choice
		input = gets.strip
        until input.to_i > 0 && input.to_i < 7
        	puts "Please enter a number 1-6"
        	input = gets.strip
        end
		if input == "1"
			puts "It is currently #{@the_city.forecast}."
		elsif input == "2"
			puts "It is currently #{@the_city.temperature}, and #{@the_city.feels_like}."
		elsif input == "3"
			puts "High: #{@the_city.high}, Low: #{@the_city.low}"
		elsif input == "4"
			puts "The humidity is #{@the_city.humidity}."
		elsif input == "5"
			puts "Sunrise: #{@the_city.sunrise}, Sunset: #{@the_city.sunset}"
		end

		start_over
	end


	def start_over 
		puts "Enter 'back' to go back to the list of forecast choices, enter cities' to see the list of cities, or 'exit'"
        input = gets.strip.downcase 
		until input == "back" || input == "cities" || input == "exit"
			puts "Please enter your choice again"
		end
		case input
		when "back"
			forecast_type
		when "cities"
			list_cities
		when "exit"
			puts "Goodbye!"
		end
	end



end