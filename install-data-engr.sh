#!/usr/bin/env bash

export SANDBOX_CONF_HOME=${SANDBOX_CONF_HOME:-$HOME/.engrsb}
export SANDBOX_ENGR_BIN=${SANDBOX_ENGR_BIN:-$SANDBOX_CONF_HOME/bin}

# [daff](https://github.com/paulfitz/daff) library for comparing tables, producing a summary of their differences
rm -f $SANDBOX_ENGR_BIN/daff
ln -s $SANDBOX_CONF_HOME/dist/daff-haxe2cpp-amd64-debug $SANDBOX_ENGR_BIN/daff

# [Miller](https://github.com/johnkerl/miller) is like awk, sed, cut, join, and sort for name\-indexed data such as CSV, TSV, and tabular JSON
export MILLER_REPO="johnkerl/miller"
export MILLER_VERSION=`curl -s https://api.github.com/repos/${MILLER_REPO}/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")'`
curl -L https://github.com/${MILLER_REPO}/releases/download/${MILLER_VERSION}/mlr.linux.x86_64 \
     -o ${SANDBOX_ENGR_BIN}/mlr
chmod +x ${SANDBOX_ENGR_BIN}/mlr

# [csvtk](https://github.com/shenwei356/csvtk) is a cross-platform, efficient and practical CSV/TSV toolkit in Golang
export CSVTK_REPO="shenwei356/csvtk"
export CSVTK_VERSION=`curl -s https://api.github.com/repos/${CSVTK_REPO}/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")'`
curl -L https://github.com/${CSVTK_REPO}/releases/download/${CSVTK_VERSION}/csvtk_linux_amd64.tar.gz \
      | tar -xz -C $SANDBOX_ENGR_BIN csvtk

# [xsv](https://github.com/BurntSushi/xsv) is a fast CSV command line toolkit written in Rust.
export XSV_REPO="BurntSushi/xsv"
export XSV_VERSION=`curl -s https://api.github.com/repos/${XSV_REPO}/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")'`
curl -L https://github.com/${XSV_REPO}/releases/download/${XSV_VERSION}/xsv-0.13.0-i686-unknown-linux-musl.tar.gz \
      | tar -xz -C $SANDBOX_ENGR_BIN xsv

# [OctoSQL](https://github.com/cube2222/octosql) is a query tool that allows you to join, analyse and transform data from multiple databases and file formats using SQL.
export OCTOSQL_REPO="cube2222/octosql"
export OCTOSQL_VERSION=`curl -s https://api.github.com/repos/${OCTOSQL_REPO}/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")'`
curl -L https://github.com/${OCTOSQL_REPO}/releases/download/${OCTOSQL_VERSION}/octosql-linux \
     -o ${SANDBOX_ENGR_BIN}/octosql
chmod +x ${SANDBOX_ENGR_BIN}/octosql

# [q](http://harelba.github.io/q/) - Run SQL directly on CSV or TSV files
export Q_TEXT_AS_DATA_DEB_SRC=https://github.com/harelba/packages-for-q/raw/master/deb/q-text-as-data_2.0.9-2_amd64.deb
TEMP_DEB="$(mktemp)" && curl -L $Q_TEXT_AS_DATA_DEB_SRC -o "$TEMP_DEB" && sudo dpkg -i "$TEMP_DEB" && rm -f "$TEMP_DEB"

# TODO others to consider:
#
# * A list of command line tools for manipulating structured text data
#   https://github.com/dbohdan/structured-text-tools
#
# * eBay's TSV Utilities: Command line tools for large, tabular data files. Filtering, statistics, sampling, joins and more.
#  https://github.com/eBay/tsv-utils
#
# * pgLoader can either load data from files, such as CSV or Fixed-File Format; or migrate a whole database to PostgreSQL
#   https://pgloader.io/