FROM rust:slim-buster
RUN sudo apt install git-all && git clone https://github.com/chenxiaolong/Custota && cd Custota && cargo build --release
COPY Custota/target/release/custota-tool /
RUN ./custota-tool gen-csig --input ota.zip --key ota.key  --cert ota.crt

RUN caddy file-server --access-log --listen :8080 --path /
