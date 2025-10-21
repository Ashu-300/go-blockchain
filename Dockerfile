# --- STAGE 1: BUILD THE APPLICATION ---
# Use the official Go image for the builder stage
FROM golang:1.25-alpine AS builder

# Set necessary environment variables
ENV GO111MODULE=on

# Set the current working directory inside the container
WORKDIR /app

# Copy the go.mod and go.sum files to the working directory
COPY go.mod go.sum ./

# Download all required dependencies. This layer is cached if dependencies don't change.
RUN go mod download

# Copy the source code into the container
COPY . .

# Build the application. The -o flag sets the output filename to 'blockchain-app'.
# -ldflags="-w -s" optimizes the binary size.
RUN go build -o blockchain-app .

# --- STAGE 2: CREATE THE FINAL CONTAINER ---
# Use a minimal base image for the final stage
FROM alpine:latest

# Update the image and install ca-certificates for secure connections (HTTPS)
RUN apk --no-cache add ca-certificates

# Set the working directory
WORKDIR /root/

# Copy the compiled binary from the builder stage
COPY --from=builder /app/blockchain-app .

# Expose the port the application listens on (defined in main() as :3000)
EXPOSE 3000

# Command to run the executable when the container starts
CMD ["./blockchain-app"]