class Project < ApplicationRecord
  has_many_attached :images

  validates :title, presence: true
  validates :description, presence: true
  validates :github_url, format: { with: URI.regexp(%w[http https]), message: "harus diawali dengan http:// atau https://" }, allow_blank: true
  extend FriendlyId
  friendly_id :title, use: :slugged
end
