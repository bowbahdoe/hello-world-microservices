require_relative './goodnight_world'
require "test/unit"



class TestGoodnightWorld < Test::Unit::TestCase
  def test_message
    assert_equal GoodnightWorld.handler(event: nil, context: nil), "Good Night World!"
  end

end
