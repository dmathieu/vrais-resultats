class Candidat < ActiveRecord::Base
  belongs_to :area
  belongs_to :round

  validates :nom,
    presence: true,
    uniqueness: {scope: [:area_id, :round_id]}
end
