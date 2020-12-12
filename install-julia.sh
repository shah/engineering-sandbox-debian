#!/usr/bin/env bash

export SANDBOX_POLYLANG_HOME=${SANDBOX_POLYLANG_HOME:-$SANDBOX_CONF_HOME/lang}
export JULIA_HOME=${JULIA_HOME:-$SANDBOX_POLYLANG_HOME/julia}
export JULIA_REPO=${JULIA_REPO:-JuliaLang/julia}
export JULIA_VERSION=${JULIA_VERSION:-`curl -s https://api.github.com/repos/${JULIA_REPO}/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")'`}
export JULIA_LATEST_SYMLINK_VERSION=${JULIA_LATEST_SYMLINK_VERSION:-$JULIA_HOME/julia-${JULIA_VERSION:1}}
if [[ ${JULIA_VERSION:1} =~ ^[0-9]+\.[0-9]+ ]]; then
     JULIA_MAJOR_MINOR_ONLY=${BASH_REMATCH[0]}
     echo "Installing Julia version $JULIA_VERSION from $JULIA_MAJOR_MINOR_ONLY S3 source into $JULIA_HOME"
     mkdir -p $JULIA_HOME
     curl -Ls https://julialang-s3.julialang.org/bin/linux/x64/${JULIA_MAJOR_MINOR_ONLY}/julia-${JULIA_VERSION:1}-linux-x86_64.tar.gz | tar -xz -C $JULIA_HOME
     rm -f $JULIA_HOME/latest
     ln -s $JULIA_LATEST_SYMLINK_VERSION $JULIA_HOME/latest
     echo "Julia $JULIA_VERSION installed in $JULIA_HOME, $JULIA_HOME/latest symlinked to ${JULIA_LATEST_SYMLINK_VERSION}"
else
     echo "Unable to determine Julia version information for curl download." >&2
fi
