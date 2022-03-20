#!/bin/bash

set -e
set -v
set -x

# Install git repository from branch
cd ${START_DIR}
git clone --depth 1 $1.git -b $2 tmp-install
cd tmp-install
./autogen.sh
if [ ${DISTRO_NAME} == "debian" -o ${DISTRO_NAME} == "ubuntu" ];then
    ./configure --prefix=/usr --libdir=/usr/lib/x86_64-linux-gnu --libexecdir=/usr/lib/x86_64-linux-gnu
else
    ./configure --prefix=/usr
fi
make
make install
cd ..
rm -rf tmp-install
