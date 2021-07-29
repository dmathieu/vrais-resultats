class Area < ActiveRecord::Base
  belongs_to :event
  has_many :results,
    dependent: :destroy

  validates :path,
    uniqueness: {scope: :event_id}
end
