FROM rust AS depdencies

COPY . .

RUN wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -
RUN apt-get update
RUN apt-get install -y clang npm
RUN rustup target add wasm32-unknown-unknown
RUN cargo install wasm-bindgen-cli
RUN npm install

FROM depdencies AS builder
RUN npm run build

FROM builder AS server

ENTRYPOINT npm run serve
