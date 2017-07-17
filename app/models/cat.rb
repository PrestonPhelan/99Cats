class Cat < ApplicationRecord
  COLORS = ["orange", "tabby", "calico"].freeze


  validates :birth_date, :color, :name, :sex, presence: true
  validates :sex, length: { maximum: 1 }
  validates :color, inclusion: { in: COLORS }
end
