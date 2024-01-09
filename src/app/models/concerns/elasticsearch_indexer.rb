module ElasticsearchIndexer
  extend ActiveSupport::Concern
  included do
    def index_elasticsearch
      ElasticsearchWorker.perform_async(self.class.to_s, id)
      self
    end
  end
end