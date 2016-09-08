# sidekiq-pubsub

## Proposed API

```
Sidekiq.publish 'rectify_claims', claim.id

Sidekiq.subscribe do
  on 'rectify_claims', RectifyClaimsWorker
  on 'rectify_claims', ClaimRenewalJob
end
```

