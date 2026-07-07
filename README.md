# tekton-catalog

Tekton tasks provided by the Conforma team.

This repository contains the source for Tekton verification tasks used in
[Konflux](https://github.com/konflux-ci) release pipelines. Tasks are synced
from the [conforma/cli](https://github.com/conforma/cli/) repository and
consumed as Tekton Bundles via the
[release-service-catalog](https://github.com/konflux-ci/release-service-catalog).

## Syncing tasks from conforma/cli

Task definitions originate in the [conforma/cli](https://github.com/conforma/cli/)
repository. To sync them into this catalog:

```bash
hack/sync-ec-cli-tasks.sh <PATH_TO_EC_CLI_REPO>
```
