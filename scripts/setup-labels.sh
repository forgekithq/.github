#!/usr/bin/env bash
# Setup shared labels for a Forgekit repository.
# Usage: ./scripts/setup-labels.sh <owner/repo>
# Example: ./scripts/setup-labels.sh forgekithq/envguard

set -euo pipefail

REPO="${1:?Usage: $0 <owner/repo>}"

echo "Setting up labels for $REPO..."

# Delete GitHub defaults we don't use
gh label delete "invalid" --repo "$REPO" --yes 2>/dev/null || true
gh label delete "question" --repo "$REPO" --yes 2>/dev/null || true

# Type
gh label create "bug"            --color "d73a4a" --description "Something isn't working"        --repo "$REPO" --force
gh label create "enhancement"    --color "a2eeef" --description "New feature or improvement"     --repo "$REPO" --force
gh label create "documentation"  --color "0075ca" --description "Documentation only"             --repo "$REPO" --force
gh label create "breaking"       --color "b60205" --description "Breaking change"                --repo "$REPO" --force
gh label create "dependencies"   --color "0366d6" --description "Dependency updates"             --repo "$REPO" --force

# Status
gh label create "triage"           --color "fbca04" --description "Needs review"           --repo "$REPO" --force
gh label create "good first issue" --color "7057ff" --description "Good for newcomers"     --repo "$REPO" --force
gh label create "help wanted"      --color "008672" --description "Extra attention needed"  --repo "$REPO" --force
gh label create "duplicate"        --color "cfd3d7" --description "Already exists"          --repo "$REPO" --force
gh label create "wontfix"          --color "d0d7de" --description "Not planned"             --repo "$REPO" --force

# Priority
gh label create "priority: critical" --color "b60205" --description "Must fix immediately"  --repo "$REPO" --force
gh label create "priority: high"     --color "d93f0b" --description "Fix this sprint"       --repo "$REPO" --force
gh label create "priority: low"      --color "c5def5" --description "Nice to have"          --repo "$REPO" --force

# Stream
gh label create "stream: envguard"        --color "1d76db" --description "Related to envguard"          --repo "$REPO" --force
gh label create "stream: saas-starter"    --color "5319e7" --description "Related to SaaS Starter Kit"  --repo "$REPO" --force
gh label create "stream: screenshot-api"  --color "0e8a16" --description "Related to Screenshot API"    --repo "$REPO" --force
gh label create "stream: brand-site"      --color "e4e669" --description "Related to brand site"        --repo "$REPO" --force

echo "Done. Labels set up for $REPO."
