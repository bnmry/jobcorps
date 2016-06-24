require File.dirname(__FILE__) + '/../test_helper'
require 'resumes_controller'

# Re-raise errors caught by the controller.
class ResumesController; def rescue_action(e) raise e end; end

class ResumesControllerTest < Test::Unit::TestCase
  def setup
    @controller = ResumesController.new
    request    = ActionController::TestRequest.new
    response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
