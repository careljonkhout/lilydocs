require 'test_helper'

class ScoreTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Score.new.valid?
  end
end
