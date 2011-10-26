dir = File.dirname(File.expand_path(__FILE__))

require 'rubygems'
require 'test/unit'
require 'resque'
require File.join(dir, '../lib/resque-fallback-inline')
$LOAD_PATH.unshift dir + '/../lib'
require 'ruby-debug'

#
# make sure we can run redis
#

if !system("which redis-server")
  puts '', "** can't find `redis-server` in your path"
  puts "** try running `sudo rake install`"
  abort ''
end

def kill_redis_test_processes
  dir = File.dirname(File.expand_path(__FILE__))
  processes = `ps -A -o pid,command | grep [r]edis-test`.split("\n")
  pids = processes.map { |process| process.split(" ")[0] }
  puts "Killing test redis server..."
  `rm -f #{dir}/dump.rdb #{dir}/dump-cluster.rdb`
  pids.each { |pid| Process.kill("KILL", pid.to_i) }
end

def start_redis_test_processes
  dir = File.dirname(File.expand_path(__FILE__))
  puts "Starting redis for testing at localhost:9736..."
  `redis-server #{dir}/redis-test.conf`
  Resque.redis = 'localhost:9736'
end

#
# fixture classes
#

class SomeJob

  def self.queue
    :queue
  end

  def self.perform
    @performed ||= 0
    @performed += 1
  end

  def self.performed
    @performed
  end

  def self.reset
    @performed = 0
  end
end
