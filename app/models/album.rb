class Album < ApplicationRecord
  validates_length_of :title, minimum: 1, maximum: 100
  belongs_to :user
end
