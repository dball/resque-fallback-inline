require 'test_helper'

class ResqueFallbackInlineTest < Test::Unit::TestCase

  def test_resque_falls_back_inline_when_redis_is_dead
    start_redis_test_processes
    kill_redis_test_processes
    SomeJob.reset
    assert_equal 0, SomeJob.performed
    assert Resque.enqueue(SomeJob)
    assert_equal 1, SomeJob.performed
  end

end
