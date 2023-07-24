#!/bin/bash

# $ rustup toolchain install stable-i686-unknown-linux-gnu
# $ rustup target add x86_64-unknown-linux-gnu --toolchain stable-i686-unknown-linux-gnu

set -e

export T32=i686-unknown-linux-gnu
export T64=x86_64-unknown-linux-gnu

rm -r build || true ; mkdir build

rustc +stable-$T32 --target $T64 --edition 2021 -C metadata=p --crate-name p p.rs -o build/libp.rlib
rustc +stable-$T32 --target $T64 --edition 2021 -C metadata=l --crate-name l l.rs -o build/libl.rlib --extern p=build/libp.rlib

# Copy for debugging purposes
cp -r build buildb

rm build/libp.rlib
rustc +stable-$T64 --target $T64 --edition 2021 -C metadata=p --crate-name p p.rs -o build/libp.rlib
rustc +stable-$T64 --target $T64 --edition 2021 -C metadata=b --crate-name b b.rs -o build/bin --extern l=build/libl.rlib -L dependency=build

chmod u+x build/bin
./build/bin
