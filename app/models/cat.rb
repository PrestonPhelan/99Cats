class Cat < ApplicationRecord
  COLORS = %w(black white orange brown)

  validates :birth_date, :color, :name, :sex, presence: true
  validates :sex, inclusion: %w(M F)
  validates :color, inclusion: COLORS

  has_many :cat_rental_requests, dependent: :destroy

  def age
    (Date.today - birth_date).to_i / 365
  end
end
