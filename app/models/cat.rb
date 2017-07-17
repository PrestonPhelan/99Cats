class Cat < ApplicationRecord
  COLORS = %w(black white orange brown)


  validates :birth_date, :color, :name, :sex, presence: true
  validates :sex, inclusion: %w(M F)
  validates :color, inclusion: COLORS
end
