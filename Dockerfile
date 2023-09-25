# Use the official Rust image as the base image
FROM rust:slim-buster

# Set the working directory
WORKDIR /app

# Copy the entire project directory into the image (assuming Custota is in the same directory as Dockerfile)
COPY . /app

# Install necessary packages and cleanup
RUN sudo apt install git-all -y && git clone https://github.com/chenxiaolong/Custota && cd Custota/custota-tool && cargo build --release
COPY Custota/target/release/custota-tool /
    
# Set the entry point and default command
CMD ["./Custota/target/release/custota-tool", "gen-csig", "--input", "ota.zip", "--key", "ota.key", "--cert", "ota.crt"]
