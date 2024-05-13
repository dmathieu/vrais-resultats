# frozen_string_literal: true

class Event < ActiveRecord::Base
  has_many :rounds
  has_many :areas

  validates :name,
            presence: true,
            uniqueness: true

  def path
    "/#{name.parameterize}"
  end
end
