class ElasticsearchWorker
  include Sidekiq::Worker
  sidekiq_options retry: 10
  def perform(clazz, id)
    Rails.logger.debug("Indexing #{clazz} id #{id}")
    clazz.constantize.find(id).reindex
  end
end