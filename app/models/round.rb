# frozen_string_literal: true

class Round < ActiveRecord::Base
  belongs_to :event
  has_many :results,
           dependent: :destroy
  has_many :candidats,
           dependent: :destroy

  validates :name,
            presence: true,
            uniqueness: { scope: :event_id }
end
