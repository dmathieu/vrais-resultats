# frozen_string_literal: true

class Result < ActiveRecord::Base
  belongs_to :area
  belongs_to :round
  has_many :candidats

  validates :area_id,
            presence: true,
            uniqueness: { scope: :round_id }

  validates :round_id,
            presence: true,
            uniqueness: { scope: :area_id }
end
