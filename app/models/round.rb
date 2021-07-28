class Round < ActiveRecord::Base
  belongs_to :event

  validates :name,
    presence: true,
    uniqueness: { scope: :event_id }
end
