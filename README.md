# sidekiq-pubsub

## Proposed API

```
# Proposed API
#
Sidekiq.publish 'rectify_claims', claim.id

Sidekiq.subscribe do
  on 'rectify_claims', RectifyClaimsWorker
  on 'rectify_claims', ClaimRenewalJob
end

Sidekiq.subscribe do
  on 'rectify_claims', (event) -> {
    RectifyClaimsWorker.perform_async(event.args, extra_options={})
  }
end
```
