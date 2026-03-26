# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Tekton task catalog for the Conforma (Enterprise Contract) team. Provides reusable verification tasks consumed as Tekton Bundles. Tasks are primarily synced from the [ec-cli](https://github.com/conforma/cli/) repository.

**Status:** Experimental — tasks are produced and bundled by the ec-cli repo; this catalog tracks and publishes them.

## Tasks

Located in `tasks/`, each versioned in subdirectories:

| Task | Purpose |
|------|---------|
| `verify-conforma-konflux-ta` | Verify Conforma policies in Konflux with Trusted Artifacts |
| `verify-conforma-konflux-vsa-ta` | Verify Conforma policies using VSA with Trusted Artifacts |
| `verify-definition` | Verify Tekton pipeline/task definitions against policies |
| `verify-enterprise-contract` | Verify Enterprise Contract policies (legacy name) |

## Key Scripts

```bash
# Sync tasks from ec-cli repository
hack/sync-ec-cli-tasks.sh
```

## Testing

Tasks with tests have a `tests/` subdirectory containing TaskRun definitions:
```bash
# verify-enterprise-contract has a test runner
tasks/verify-enterprise-contract/tests/run.sh
```

## Structure

- `tasks/<task-name>/<version>/` — versioned task YAML definitions
- `tasks/<task-name>/<version>/tests/` — test TaskRun definitions
- `hack/` — utility scripts (task sync from ec-cli)
- `.github/workflows/` — CI automation (auto-merge, labeling, task sync)
- `renovate.json` — automated dependency updates
