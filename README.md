# OdonataOverture

A Rails 8 application with modern features including Hotwire, Solid Cache, Solid Queue, and Solid Cable.

## Prerequisites

- Ruby 3.4.6
- Node.js (for asset compilation)
- SQLite3

## Local Development Setup

### Option 1: Using Docker (Recommended)

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd OdonataOverture
   ```

2. **Build the Docker image**
   ```bash
   docker build -t odonata_overture .
   ```

3. **Run the application**
   ```bash
   docker run -d -p 3000:80 -e RAILS_MASTER_KEY=$(cat config/master.key) --name odonata_overture odonata_overture
   ```

   The application will be available at `http://localhost:3000`

4. **Stop the container**
   ```bash
   docker stop odonata_overture
   docker rm odonata_overture
   ```

### Option 2: Local Development (Without Docker)

1. **Install Ruby 3.4.6**
   ```bash
   # Using rbenv
   rbenv install 3.4.6
   rbenv local 3.4.6

   # Or using rvm
   rvm install 3.4.6
   rvm use 3.4.6
   ```

2. **Install dependencies**
   ```bash
   bundle install
   ```

3. **Setup the database**
   ```bash
   bin/rails db:create
   bin/rails db:migrate
   ```

4. **Start the development server**
   ```bash
   bin/rails server
   ```

   The application will be available at `http://localhost:3000`

## Development Commands

- **Run tests**: `bin/rails test`
- **Run linter**: `bin/rubocop`
- **Run security scanner**: `bin/brakeman`
- **Console**: `bin/rails console`

## Technology Stack

- **Framework**: Rails 8.0.3
- **Database**: SQLite3
- **Web Server**: Puma with Thruster
- **Frontend**: Hotwire (Turbo + Stimulus)
- **Asset Pipeline**: Propshaft
- **Caching**: Solid Cache
- **Background Jobs**: Solid Queue
- **WebSockets**: Solid Cable
