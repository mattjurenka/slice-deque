# Build Stage
FROM --platform=linux/amd64 rustlang/rust:nightly as builder

ENV DEBIAN_FRONTEND=noninteractive
## Install build dependencies.
RUN apt-get update 
RUN apt-get install -y cmake clang
RUN cargo install cargo-fuzz

## Add source code to the build stage.
ADD . /slice_deque/

## TODO: ADD YOUR BUILD INSTRUCTIONS HERE.

WORKDIR /slice_deque/fuzz/
RUN cargo fuzz build

FROM --platform=linux/amd64 rustlang/rust:nightly

## TODO: Change <Path in Builder Stage>
COPY --from=builder /slice_deque/fuzz/target/x86_64-unknown-linux-gnu/release/construct_queue /
