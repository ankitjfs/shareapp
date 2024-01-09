class Resource < ApplicationRecord
  include ElasticsearchIndexer

  searchkick callbacks: false, text_middle: [:name, :description]
  after_commit :index_elasticsearch

  enum :status, [ :available, :allocated, :archived ]

  def search_data
    {
      id: id,
      name: name,
      description: description,
      user_id: user_id,
      company_id: company_id,
      status: status
    }
  end

  belongs_to :company
  belongs_to :user
  has_many :allotments
  has_many :resource_subscribers
end
