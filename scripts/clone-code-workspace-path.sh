# Helper script to take a VS Code *.code-workspace file via STDIN and clone all folders contained in it.
# Git clone credentials for each repo source (e.g. GitHub, GitLab) must already be set.

jq -r '.folders[] | "test ! -d \(.path) && mkdir -p \(.path) && git clone https://\(.path) \(.path)"'

# Common usage:
#   mkdir -p $HOME/workspaces
#   curl -L -o sample.code-workspace https://shah/vscode-workspaces/sample.code-workspace
#   cat sample.code-workspace | $HOME/.engrsb/scripts/clone-code-workspace-path.sh | sh
#
# The convention is that the .folder[].path values are both the name of the cloned directories as well
# as the source repo's domain so that https://${.folder.path} will be the source repo.
#
# If the following folders are in `sample.code-workspace`:
# {
# 	"folders": [
# 		{ "path": "github.com/shah/uniform-resource" },
# 		{ "path": "github.com/medigy/uniform-resource-classifier-nih-mesh" },
# 		{ "path": "git.netspective.io/netspective-studios/gmail-classify-anchors" }
# 	],
#
# Then the following folders will be created after cloning:
# ❯ tree -d -L 3
# ├── github.com
# │   ├── medigy
# │   │   └── uniform-resource-classifier-nih-mesh
# │   └── shah
# │       └── uniform-resource
# └── git.netspective.io
#     └── netspective-studios
#         └── gmail-classify-anchors