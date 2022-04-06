class MenuItem < ApplicationRecord
  belongs_to :category

  validates :name, presence: true

  scope :available_appetizers, -> { where(available: true, category_id: 1)}
  scope :available_entrees, -> { where(available: true, category_id: 2)}
  scope :available_drinks, -> { where(available: true, category_id: 3)}
end
