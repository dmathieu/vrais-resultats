class Event < ActiveRecord::Base
  has_many :rounds
  has_many :areas

  validates :name,
    presence: true,
    uniqueness: true
end
