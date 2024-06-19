class User < ApplicationRecord
  has_many :albums, dependent: :destroy

  validates :name, :username, :email, :phone, :company, presence: true
  validates :username, :email, uniqueness: true
  validates :name, :username, length: { minimum: 4, maximum: 32 }
  validates :phone, numericality: { only_integer: true }
end
