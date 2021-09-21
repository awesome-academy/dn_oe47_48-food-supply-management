class Town < ApplicationRecord
  belongs_to :district
  has_many :users, dependent: :nullify

  delegate :name, to: :district, prefix: true
  validates :name, presence: true
end
