#!/bin/bash

set -e
set -v
set -x

# Install git repository from branch
cd ${START_DIR}
git clone --depth 1 $1.git -b $2 tmp-install
cd tmp-install
if [ -f "autogen.sh" ]; then
    if ./autogen.sh;then
        echo $1 $2 ./autogen.sh OK!
    else
        echo $1 $2 ./autogen.sh ERROR!
        exit 1
    fi
fi
if [ "${3}" = "meson" ]; then
    meson $4 _build
    ninja -C _build
    ninja -C _build install
else
    if [ $# -eq 3 ];then
        ./configure $3
    else
        if [ ${DISTRO_NAME} == "debian" -o ${DISTRO_NAME} == "ubuntu" ];then
            ./configure --prefix=/usr --libdir=/usr/lib/x86_64-linux-gnu --libexecdir=/usr/lib/x86_64-linux-gnu
        else
            ./configure --prefix=/usr
        fi
    fi
    if make;then
        echo $1 $2 make OK!
    else
        echo $1 $2 make ERROR!
        exit 1
    fi
    if make install;then
        echo $1 $2 make install OK!
    else
        echo $1 $2 make install ERROR!
        exit 1
    fi
fi
cd ..
rm -rf tmp-install
