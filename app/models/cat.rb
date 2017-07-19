class Cat < ApplicationRecord
  COLORS = %w(black white orange brown)

  validates :birth_date, :color, :name, :sex, :owner, presence: true
  validates :sex, inclusion: %w(M F)
  validates :color, inclusion: COLORS

  has_many :cat_rental_requests, dependent: :destroy
  belongs_to :owner,
    foreign_key: :user_id,
    class_name: :User

  def age
    (Date.today - birth_date).to_i / 365
  end
end
