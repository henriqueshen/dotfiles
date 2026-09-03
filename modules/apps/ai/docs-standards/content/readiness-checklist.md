# Readiness checklist

Apply this checklist to a built system before it ships to users, and again before any change that alters its failure modes, data, or dependencies. Every item is answered against the running system, with the evidence named (a test run, a drill, a dashboard, a document). An item that cannot be answered is a finding, and each finding is either fixed before shipping or recorded as a tracker issue with the hardening kind label and an owner.

The checklist follows the categories of Google's launch coordination checklist and the AWS operational readiness review. Those documents are the models. This file is the instance used here.

## Scope

- [ ] The change and the users it reaches are stated in one paragraph, with what is out of scope.
- [ ] The spec the change was built from is linked, and its status is implemented.
- [ ] Every item the spec deferred has a tracker issue.

## Architecture and dependencies

- [ ] Every runtime dependency (services, stores, queues, third-party APIs) is listed with what happens when it is slow, returns errors, or is unavailable.
- [ ] No dependency creates a call cycle, and no request path performs an unbounded scan or holds a global lock.
- [ ] Timeouts, retries with backoff, and a retry budget exist on every outbound call.
- [ ] The system degrades in a stated order when dependencies fail, and that order was exercised.

## Capacity and performance

- [ ] Expected load at launch and at ten times launch is written down, with the measurement it came from.
- [ ] A load test at ten times launch was run against the shipped configuration, and its results are linked.
- [ ] Latency targets exist for the user-visible operations, and the load test met them.
- [ ] Resource limits (connections, memory, file descriptors, queue depth) are set, and the behaviour at each limit was observed.
- [ ] Per-user and per-client rate limits exist on every write path and on expensive reads.

## Failure and recovery

- [ ] Each component's failure modes are listed with the detection signal and the recovery action for each.
- [ ] Loss of one instance, one zone, and the primary store was exercised, and the system recovered as described.
- [ ] Recovery point and recovery time objectives are stated per data class.
- [ ] Backups run on a schedule, and a restore from backup was exercised into a fresh environment within the recovery time objective.
- [ ] A restore drill verified that deleted data stays deleted after restore.
- [ ] Every write is idempotent under retry, and duplicate delivery of every event was tested.

## Data

- [ ] Every dataset is listed with its owner, retention period, deletion path, and whether it contains personal data.
- [ ] Account deletion removes or anonymises every dataset that references the account, and this was exercised end to end.
- [ ] Data export for a user was exercised end to end.
- [ ] Schema migrations are additive first and compatible with one release of rollback.
- [ ] Storage growth per user and per day is measured and bounded.

## Security and privacy

- [ ] Trust boundaries are drawn, and every input crossing one is validated and size-bounded.
- [ ] Authentication and authorization are enforced at the service, not only at the gateway, and a negative test exists for each protected operation.
- [ ] Secrets live in the secret store, never in code, configuration files, logs, or artifacts.
- [ ] Service-to-service and client-to-service traffic is encrypted, and stores encrypt at rest.
- [ ] Human access to production data goes through an audited path with no standing credentials.
- [ ] Dependencies were scanned for known vulnerabilities, and the results are linked.
- [ ] Abuse cases (spam, scraping, enumeration, resource exhaustion) are listed with the control for each.

## Observability

- [ ] Every user-visible operation emits latency, error rate, and throughput metrics.
- [ ] Alerts exist for each service level objective, and each alert links to a runbook.
- [ ] Logs carry a request identifier that traces one request across services, and contain no personal data or secrets.
- [ ] A dashboard shows the health of the system and of each dependency.

## Operations

- [ ] Runbooks exist for each alert and for the routine operations (deploy, rollback, scale, restore, rotate secrets), each with preconditions, steps with expected results, verification, rollback, and escalation.
- [ ] An on-call owner is named, and the escalation path is written down.
- [ ] Deploy and rollback were exercised, and rollback completes within the stated time.
- [ ] Feature flags exist for the user-visible behaviour, and turning the feature off was exercised.

## Rollout

- [ ] The rollout is staged (internal, a percentage of users, everyone), with the metric that gates each stage and the threshold that halts it.
- [ ] The communication plan for a failed rollout names who is told and how.
- [ ] After launch, a date is set to review the metrics and close or reprioritise the hardening issues.

## References

- Google, Site Reliability Engineering, "Reliable Product Launches at Scale" and the launch coordination checklist: <https://sre.google/sre-book/reliable-product-launches/>, <https://sre.google/sre-book/launch-checklist/>
- AWS Well-Architected, Operational Readiness Reviews: <https://docs.aws.amazon.com/wellarchitected/latest/operational-readiness-reviews/wa-operational-readiness-reviews.html>
- Google, Site Reliability Engineering, "Data Integrity: What You Read Is What You Wrote": <https://sre.google/sre-book/data-integrity/>
