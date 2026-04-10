# frozen_string_literal: true

class PaypalAdapter
  def initialize(user)
    @user = user
    puts "Initialized PayPal for user #{@user.name} with account #{@user.account_id}."
  end

  def make_payment(amount)
    puts "Processing payment of #{amount} through PayPal."
  end
end

class StripeAdapter
  def initialize(user)
    @user = user
    puts "Initialized Stripe for user #{@user.name} with credit card #{@user.credit_card}."
  end

  def make_payment(amount)
    puts "Processing payment of #{amount} through Stripe."
  end
end

class User
  attr_reader :name, :account_id, :credit_card

  def initialize(name, account_id, credit_card)
    @name = name
    @account_id = account_id
    @credit_card = credit_card
  end
end

class PaymentProcessor
  def initialize(adapter, user)
    @adapter = adapter
    puts "PaymentProcessor initialized with #{adapter}."
    @user = user
  end

  def process(amount)
    puts "Preparing to process payment of #{amount}."
    @adapter.new(@user).make_payment(amount)
  end
end

class CheckoutService
  def initialize(payment_processor)
    @payment_processor = payment_processor
  end

  def checkout(amount)
    puts "Starting checkout for amount: #{amount}"
    @payment_processor.process(amount)
  end
end

puts "###############################################"
user_one = User.new("Alice", "alice123", "4111-1111-1111-1111")
payment_processor = PaymentProcessor.new(PaypalAdapter, user_one)
checkout_service = CheckoutService.new(payment_processor)
checkout_service.checkout(100)

puts "###############################################"
payment_processor = PaymentProcessor.new(StripeAdapter, user_one)
checkout_service = CheckoutService.new(payment_processor)
checkout_service.checkout(120)
