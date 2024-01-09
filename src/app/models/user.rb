class User < ApplicationRecord
  has_secure_password
  enum :status, [ :created, :verified ]
  validates :work_email, presence: true, uniqueness: true
  validates :work_email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password,
            length: { minimum: 6 },
            if: -> { new_record? || !password.nil? }

  belongs_to :company
  has_many :resources
  has_many :allotments, through: :resources
  has_many :resource_subscribers
end
