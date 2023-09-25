# Use the official Rust image as the base image
FROM rust:slim-buster

# Set the working directory
WORKDIR /app

# Install necessary packages and cleanup
RUN apt-get update && \
    apt-get install -y git && \
    git clone https://github.com/chenxiaolong/Custota && \
    cd Custota/custota-tool && \
    cargo build --release && \
    apt-get remove -y git && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

# Copy the built executable to the root directory
COPY Custota/target/release/custota-tool /custota-tool

# Set the entry point and default command
CMD ["./custota-tool", "gen-csig", "--input", "ota.zip", "--key", "ota.key", "--cert", "ota.crt"]
