# Golang Blockchain Book System

This project is a **Blockchain-based Book Checkout System** built with **Golang**. It demonstrates how blockchain concepts like **blocks, hashes, and validation** can be applied outside cryptocurrency—for example, managing book checkouts securely.

## Features
- Create and store books with unique IDs (MD5 hash of ISBN + publish date)
- Record book checkouts as blocks in a blockchain
- Generate and validate block hashes using SHA-256
- Immutable, linked chain with a Genesis block
- REST API endpoints:
  - `POST /newBook` → Add new books
  - `POST /` → Checkout books (add block)
  - `GET /` → Retrieve the full blockchain

## Tech Stack
- **Language:** Golang
- **Web Framework:** Gorilla Mux
- **Cryptography:** SHA-256, MD5
- **Data Format:** JSON

## Learning Outcomes
- Understanding of Golang fundamentals: structs, methods, concurrency, and routing
- Hands-on experience with blockchain data structures
- Building a REST API for real-world-like use cases
- Practical exposure to cryptography and data integrity

## Getting Started
Follow these steps to set up and run the project:

1. **Clone the repository**
```bash
git clone https://github.com/yourusername/golang-blockchain-book-system.git
cd golang-blockchain-book-system
go mod tidy
go run main.go

