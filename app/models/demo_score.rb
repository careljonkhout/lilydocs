class DemoScore < ActiveRecord::Base
  include AbstractScore
  attr_accessor :input

  def after_initialize
    self.input ||= EXAMPLE_INPUT
  end
end
