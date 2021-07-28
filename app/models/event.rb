class Event < ActiveRecord::Base
  has_many :rounds

  validates :name,
    presence: true,
    uniqueness: true
end
