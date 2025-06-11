#!/usr/bin/env bash

set -o errexit
set -o nounset

project_dir=$(cd "$(dirname "$0")" && pwd)

cd "${project_dir}/frontend/" || false

# gcc is default
clang_env="CC_wasm32_unknown_unknown=clang"

# include path to standard library is missing by default
clang_path=$(nix build --no-link --print-out-paths nixpkgs#llvmPackages.clang)
clang_env="${clang_env} CFLAGS_wasm32_unknown_unknown='-I${clang_path}/resource-root/include/'"

# https://docs.rs/getrandom/0.3.3/getrandom/#webassembly-support
getrandom_env="RUSTFLAGS='--cfg getrandom_backend=\"wasm_js\"'"

nix-shell \
  --run "export ${clang_env} ${getrandom_env} && npm run build:wasm" \
  --packages llvmPackages.clang-unwrapped wasm-pack

npm install
