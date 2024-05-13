# frozen_string_literal: true

class Candidat < ActiveRecord::Base
  belongs_to :result

  validates :nom,
            presence: true,
            uniqueness: { scope: [:result_id] }
end
