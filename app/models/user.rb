class User < ApplicationRecord
  has_many :albums, dependent: :destroy

  validates :name, :username, :email, :phone, :company, presence: true
  validates :username, :email, uniqueness: true

  before_save :downcase_email_and_username

  private

  def downcase_email_and_username
    self.email = email.downcase
    self.username = username.downcase
  end
end
