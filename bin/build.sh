#! /bin/bash

################################################################################
#
# Copyright (c) 2010 penSec.IT UG (haftungsbeschränkt)
#        http://www.pensec.it
#        mail@pensec.it
# Copyright (c) 2010 Egil Möller <egil.moller@piratpartiet.se>
# 
# Licensed under the Apache License, Version 2.0 (the "License"); you may not
# use this file except in compliance with the License. You may obtain a copy of
# the License at
# 
#        http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations under
# the License. 
#
################################################################################

ETHERPADDIR="$(cd "$(dirname "$0")/.."; pwd)"
#source "$ETHERPADDIR/bin/exports.sh"
#source "/etc/sysconfig/etherpad"

# Rebuild jar
( cd "$ETHERPADDIR"/infrastructure; ./bin/makejar.sh; )
( cd "$ETHERPADDIR"/infrastructure/ace; bin/make normal etherpad; )
cp "$ETHERPADDIR"/infrastructure/build/appjet.jar $ETHERPADDIR/etherpad/appjet-eth-dev.jar
rm -rf "$ETHERPADDIR"/infrastructure/{appjet,build,buildjs,buildcache}

# Rebuild modules
if [[ $(uname -s) != CYGWIN* ]]; then
(
  cd "$ETHERPADDIR"
  ls etherpad/src/plugins/ | while read name; do
    (
      cd "$ETHERPADDIR/etherpad/src/plugins/$name"
      if [ -e "build.sh" ]; then
        ./build.sh
      fi
    )
  done
)
fi
