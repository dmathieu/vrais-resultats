class Round < ActiveRecord::Base
  belongs_to :event
  has_many :results,
    dependent: :destroy

  validates :name,
    presence: true,
    uniqueness: {scope: :event_id}
end
