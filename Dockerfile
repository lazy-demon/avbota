FROM rust:slim-buster
RUN cd custota-tool && cargo build --release
COPY target/release/custota-tool /
RUN ./custota-tool gen-csig --input ota.zip --key ota.key  --cert ota.crt

RUN caddy file-server --access-log --listen :8080 --path /
