#!/usr/bin/env bash

export SANDBOX_CONF_HOME=${SANDBOX_CONF_HOME:-$HOME/.engrsb}
export SANDBOX_ENGR_BIN=${SANDBOX_ENGR_BIN:-$SANDBOX_CONF_HOME/bin}

# Install Sqitch DB Migration utility
apt-get -y -qq install build-essential cpanminus perl perl-doc libdbd-pg-perl postgresql-client libdbd-sqlite3-perl sqlite3 libdbd-mysql-perl
cpanm --quiet --notest App::Sqitch

export PGF_REPO="darold/pgFormatter"
export PGF_VERSION=`curl -s https://api.github.com/repos/${PGF_REPO}/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")'`
export PGF_DIST_DEST=pgFormatter-${PGF_VERSION}.tar.gz
curl -Ls https://github.com/${PGF_REPO}/archive/${PGF_VERSION}.tar.gz -o /tmp/$PGF_DIST_DEST
cd /tmp
rm -rf pgFormatter-${PGF_VERSION:1}
tar xzf $PGF_DIST_DEST
cd pgFormatter-${PGF_VERSION:1}/
perl Makefile.PL
make && sudo make install
