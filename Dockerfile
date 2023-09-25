FROM rust:slim-buster
RUN RUN gh repo clone chenxiaolong/Custota
RUN type -p curl >/dev/null || (sudo apt update && sudo apt install curl -y) curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \ && sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \ && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \ && sudo apt update \ && sudo apt install gh -y
RUN cd custota-tool && cargo build --release
COPY target/release/custota-tool /
RUN ./custota-tool gen-csig --input ota.zip --key ota.key  --cert ota.crt

RUN caddy file-server --access-log --listen :8080 --path /
