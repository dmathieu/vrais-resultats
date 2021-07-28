class Area < ActiveRecord::Base
  belongs_to :event

  validates :name,
    presence: true,
    uniqueness: { scope: :event_id }

  validates :path,
    presence: true,
    uniqueness: { scope: :event_id }
end
