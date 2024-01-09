class Company < ApplicationRecord
  enum :status, [ :created, :archived ]
  has_many :users
  has_many :resources, through: :users
  validates :email_domain, presence: true
  scope :filter_by_starts_with, -> (name) { where("name like ?", "#{name}%")}
  include Filterable
end
