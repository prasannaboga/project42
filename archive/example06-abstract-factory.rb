# frozen_string_literal: true

class SecretClient
  attr_reader :key, :value

  def initialize(key, value)
    @key = key
    @value = value
  end

  def to_s
    "#{@key}:#{@value}"
  end
end

class AwsSecretFactory
  def initialize(secret_client)
    @secret_client = secret_client
  end

  def create_secret
    puts "Creating secret aws - #{@secret_client}"
  end
end

class AzureSecretFactory
  def initialize(secret_client)
    @secret_client = secret_client
  end

  def create_secret
    puts "Creating secret azure - #{@secret_client}"
  end
end


puts "###############################################"
secret_client = SecretClient.new("editor", "vscode")
aws_secret_factory = AwsSecretFactory.new(secret_client)
aws_secret_factory.create_secret

azure_secret_factory = AzureSecretFactory.new(secret_client)
azure_secret_factory.create_secret
