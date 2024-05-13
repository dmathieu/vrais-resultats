# frozen_string_literal: true

class Area < ActiveRecord::Base
  belongs_to :event
  has_many :results,
           dependent: :destroy
  has_many :candidats,
           dependent: :destroy

  validates :path,
            uniqueness: { scope: :event_id }
end
