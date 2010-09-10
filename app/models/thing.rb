class Thing < ActiveRecord::Base
  has_many :votes
  validates_presence_of :thing, :category
end
