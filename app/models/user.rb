class User < ApplicationRecord
  has_many :albums, dependent: :destroy

  validates :name, :username, :email, presence: true
  validates :username, :email, uniqueness: true
end
