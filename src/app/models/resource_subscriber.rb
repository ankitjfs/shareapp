class ResourceSubscriber < ApplicationRecord
  enum :status, [ :pending, :triggered ]

  belongs_to :resource
  belongs_to :user
end
