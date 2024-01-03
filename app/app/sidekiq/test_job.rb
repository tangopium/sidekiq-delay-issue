class TestJob
  include Sidekiq::Job

  sidekiq_options lock: :until_and_while_executing, on_conflict: :raise

  def initialize
    logger.info "Initialize test worker"
    super
  end

  def perform
    logger.info "Start test worker"
    sleep 20
    logger.info "End test worker"
  end
end
