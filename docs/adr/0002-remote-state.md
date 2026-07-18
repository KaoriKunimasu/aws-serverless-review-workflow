# ADR 0002: Remote state in S3 with DynamoDB locking

## Status
Accepted

## Context
The dev environment started on local Terraform state. Local state has no
locking and no shared history: two applies can race (a CI run against a local
apply, or two people at once) and corrupt the file, and there is no recovery if
it is lost.

A full state backend — S3 bucket, KMS key, DynamoDB lock table, TLS-only bucket
policy, versioning — already exists in `aws-infrastructure-core`
(`bootstrap/backend`), built as a deliberate, reviewed baseline. Its ADR-001
covers the S3-vs-DynamoDB-locking reasoning; there is no reason to re-derive it
here.

## Decision
- Configure this environment's `backend "s3"` with partial config
  (`backend.hcl`, gitignored; `backend.hcl.example` is the committed template),
  pointing at the bucket and lock table from the `aws-infrastructure-core`
  bootstrap. State key: `aws-serverless-review-workflow/dev/terraform.tfstate`.
- Keep DynamoDB locking rather than S3 native lockfiles, to match
  aws-infrastructure-core and stay within the existing `>= 1.8.0` version pin
  (native lockfiles need Terraform 1.10+).
- Migrate the existing local state once:
  `terraform init -backend-config=backend.hcl -migrate-state`.

## Alternatives
- **Self-contained bootstrap in this repo.** Duplicate the S3/KMS/DynamoDB
  bootstrap here so the repo deploys without any other. Not chosen: it copies
  ~180 lines that already work in aws-infrastructure-core. Worth revisiting if
  this repo ever needs to stand entirely on its own.
- **S3 native locking (`use_lockfile`).** Drops the DynamoDB table, but raises
  the Terraform floor to 1.10+ and diverges from aws-infrastructure-core.

## Consequences
- State is shared, versioned, encrypted, and lock-protected; concurrent applies
  are safe and a lost local file is no longer fatal.
- This environment now depends on the aws-infrastructure-core backend existing
  in the same account and region (ap-southeast-2). That coupling is the price of
  not duplicating the bootstrap, and it is recorded here so it is not a surprise.
