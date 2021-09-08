class Town < ApplicationRecord
  belongs_to :district
  has_many :users, dependent: :nullify

  validates :name, presence: true
end
