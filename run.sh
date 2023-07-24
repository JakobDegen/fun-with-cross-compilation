#!/bin/bash

# $ rustup toolchain install stable-i686-unknown-linux-gnu
# $ rustup target add x86_64-unknown-linux-gnu --toolchain stable-i686-unknown-linux-gnu

set -e

export T32=i686-unknown-linux-gnu
export T64=x86_64-unknown-linux-gnu

rm -r build1 || true ; mkdir build1
rm -r build2 || true ; mkdir build2

rustc +stable-$T32 --target $T32 --edition 2021 -C metadata=a --crate-name p32 p.rs -o build1/libp32.so 
rustc +stable-$T32 --target $T64 --edition 2021 -C metadata=b --crate-name l l.rs -o build1/libl.rlib --extern p=build1/libp32.so

rustc +stable-$T64 --target $T64 --edition 2021 -C metadata=c --crate-name p64 p.rs -o build2/libp64.so
rustc +stable-$T64 --target $T64 --edition 2021 -C metadata=d --crate-name b b.rs -o build1/bin --extern l=build1/libl.rlib -L dependency=build2
