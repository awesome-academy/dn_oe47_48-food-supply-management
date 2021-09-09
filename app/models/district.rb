class District < ApplicationRecord
  has_many :towns, dependent: :destroy
  validates :name, presence: true
end
