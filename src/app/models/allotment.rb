class Allotment < ApplicationRecord
  enum :status, [ :requested, :approved, :discarded ]

  belongs_to :resource
  belongs_to :user

  include Filterable
end
