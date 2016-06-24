require File.dirname(__FILE__) + '/../test_helper'
require 'babysitter_controller'

# Re-raise errors caught by the controller.
class BabysitterController; def rescue_action(e) raise e end; end

class BabysitterControllerTest < Test::Unit::TestCase
  def setup
    @controller = BabysitterController.new
    request    = ActionController::TestRequest.new
    response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
