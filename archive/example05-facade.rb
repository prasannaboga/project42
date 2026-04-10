# frozen_string_literal: true

class User
  attr_reader :name, :credit_card

  def initialize(name, credit_card)
    @name = name
    @credit_card = credit_card
  end
end

class FlightBookingService
  attr_reader :amount

  def initialize(trip_request)
    @trip_request = trip_request
    @location = trip_request.location
    @travel_dates = trip_request.travel_dates
    @amount = nil
  end

  def book_flight
    @amount = 4000
    puts "Flight booked to #{@location} from #{@travel_dates}."
  end
end

class HotelBookingService
  attr_reader :amount

  def initialize(trip_request)
    @trip_request = trip_request
    @location = trip_request.location
    @travel_dates = trip_request.travel_dates
    @amount = nil
  end

  def book_hotel
    @amount = 3000
    puts "Hotel booked in #{@location} for dates #{@travel_dates}."
  end
end

class PaymentService
  def initialize(trip_request)
    @user = trip_request.user
  end

  def payment_amount(amount)
    puts "Processing payment of #{amount} for user #{@user.name} using credit card #{@user.credit_card}."
  end
end

class NotificationService
  def initialize(trip_request)
    @user = trip_request.user
  end

  def send_notification(message)
    puts "Notification sent to #{@user.name}: #{message}."
  end
end

class TripRequest
  attr_accessor :user, :location, :travel_dates

  def initialize(user, location, travel_dates)
    @user = user
    @location = location
    @travel_dates = travel_dates
  end

  def book_trip
    @flight_service = FlightBookingService.new(self)
    @flight_service.book_flight

    @hotel_service = HotelBookingService.new(self)
    @hotel_service.book_hotel

    @payment_service = PaymentService.new(self)
    @payment_service.payment_amount(amount)

    @notification_service = NotificationService.new(self)
    @notification_service.send_notification("Your trip has been booked successfully!")
  end

  def amount
    @flight_service.amount + @hotel_service.amount
  end
end

## Example usage
puts "###############################################"
user_one = User.new("Alice", "4111-1111-1111-1111")
trip_request = TripRequest.new(user_one, "Banglore", "2024-12-01 to 2024-12-10")
trip_request.book_trip
