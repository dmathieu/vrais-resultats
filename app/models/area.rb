class Area < ActiveRecord::Base
  belongs_to :event
  has_many :results

  validates :name,
    presence: true,
    uniqueness: { scope: :event_id }

  validates :path,
    presence: true,
    uniqueness: { scope: :event_id }
end
