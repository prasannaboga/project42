#!/usr/bin/env ruby
# frozen_string_literal: true

# Make a thread-safe Logger using Singleton

require "time"
require "date"

puts RUBY_VERSION
puts "Creating a thread-safe Logger using Singleton pattern"

class Logger
  @instance_mutex = Mutex.new

  def self.instance
    return @instance if @instance

    @instance_mutex.synchronize do
      @instance ||= new
    end

    @instance
  end

  private_class_method :new

  def initialize
    date = Date.today.to_s
    @file = File.open("logfile-#{date}.log", "a")
  end

  def log(message)
    @file.write("[#{Time.now.iso8601(0)}] #{message}\n")
  end
end

arr = []
i = 10

i.times do |i|
  arr[i] = Thread.new do
    sleep_time = rand(1..5)
    sleep(sleep_time)
    Logger.instance.log("thread tid=#{i}, slept=#{sleep_time} and completed")
  end
end

Logger.instance.log("Threads started, waiting for completion")
arr.each(&:join)
Logger.instance.log("Threads completed, total threads count=#{arr.size}")
