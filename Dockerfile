# Use the official Rust image as the base image
FROM rust:slim-buster

# Set the working directory
WORKDIR /app

# Copy the entire project directory into the image (assuming Custota is in the same directory as Dockerfile)
COPY . /app

# Install Git and other necessary packages
RUN apt-get update && apt-get install -y git

# Clone the repository, build the Rust application, and generate the csig
RUN cd Custota/custota-tool && cargo build --release && ./target/release/custota-tool gen-csig --input ota.zip --key ota.key --cert ota.crt

# Cleanup unnecessary packages
RUN apt-get remove -y git && apt-get autoremove -y && rm -rf /var/lib/apt/lists/*

# Set the entry point and default command
CMD ["/app/Custota/custota-tool/target/release/custota-tool", "gen-csig", "--input", "ota.zip", "--key", "ota.key", "--cert", "ota.crt"]
