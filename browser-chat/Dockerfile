FROM rust AS depdencies

COPY . .

RUN wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -
RUN apt-get update
RUN apt-get install -y clang npm
RUN rustup target add wasm32-unknown-unknown
RUN cargo install wasm-bindgen-cli wasm-pack
RUN cd frontend && npm run build:wasm && npm install

FROM depdencies AS builder
RUN cd frontend && npm run build

FROM builder AS server

ENTRYPOINT npx http-server frontend/dist/
