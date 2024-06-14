class Photo < ApplicationRecord
  belongs_to :album

  validates :url, :thumbnail_url, presence: true
end
