class DemoScore < ActiveRecord::Base
  include AbstractScore

  attr_accessor :input

  after_initialize :set_input_to_example_input_if_empty
end
