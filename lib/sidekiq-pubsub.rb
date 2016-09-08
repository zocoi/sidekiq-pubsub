# Proposed API
#
# Sidekiq.publish 'rectify_claims', claim.id
#
# Sidekiq.subscribe do
#   on 'rectify_claims', RectifyClaimsWorker
#   on 'rectify_claims', ClaimRenewalJob
# end
#
# Sidekiq.subscribe do
#   on 'rectify_claims', (event) -> {
#     RectifyClaimsWorker.perform_async(event.args, extra_options={})
#   }
# end

module Sidekiq
  def self.publish(event_name, payload={})
    if block_given?
      ActiveSupport::Notifications.instrument(event_name, payload) do
        yield
      end
    else
      ActiveSupport::Notifications.instrument(event_name, payload)
    end
  end
end

module Sidekiq
  def self.subscribe
    yield self if block_given?
  end
  def self.on(event_name, job_klass_or_lambda)
      # Need to control this subcriber later
      subscriber = ActiveSupport::Notifications.subscribe(event_name) do |*args|
        event = ActiveSupport::Notifications::Event.new(*args)
        job_klass.perform_async(*args)
      end
    end
  end
end
