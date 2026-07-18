terraform {
  # Partial config: real values come from backend.hcl (gitignored).
  # terraform init -backend-config=backend.hcl
  backend "s3" {}
}
