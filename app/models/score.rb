class Score < ActiveRecord::Base
  include AbstractScore
  attr_accessible :name, :input, :trashed

  after_initialize :set_input_to_example_input_if_empty

  before_save do |score|
    owner = score.owner
    if score.name.nil?
      score.name = "#{(owner.document_counter+1).ordinalize} Lilypond Document"
    end
    owner.document_counter = owner.document_counter + 1
    owner.save
  end

  belongs_to :owner, :class_name => 'User'
end
