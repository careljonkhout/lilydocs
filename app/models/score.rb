class Score < ActiveRecord::Base
  include AbstractScore
  attr_accessible :name, :input, :trashed

  def after_initialize
    self.input ||= EXAMPLE_INPUT
  end

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
