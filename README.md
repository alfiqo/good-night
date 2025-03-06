# API Good Night

## Features

- **Sleep Records**
  - Clock-in and clock-out functionality for tracking sleep sessions.
  - View sleep records of users you follow.

- **Social Interactions**
  - Follow and unfollow other users.

- **Health Check**
  - A health check endpoint to verify API availability.

- **API Documentation**
  - Swagger integration for interactive API documentation using `rswag`.

---

## Requirements

- Ruby 3.4.2
- Rails 8.0.1
- Sqlite

---

## Setup Instructions

### Clone the Repository

```bash
git clone git@github.com:alfiqo/good-night.git
cd good-night
```

### Install Dependencies

```bash
bundle install
```

### Set Up the Database

```bash
rails db:setup
```
This will create, migrate, and seed the database.

### Run the Server

```bash
rails server
```
The application will be accessible at `http://localhost:3000`.

### Health Check

Visit `http://localhost:3000/up` to ensure the application is running.

---

## API Endpoints

### Base URL

```
http://localhost:3000/api/v1
```

### API Documentation

Swagger documentation is available at:
```
http://localhost:3000/api-docs
```

---

## Testing

### RSpec

Run the test suite using:
```bash
bundle exec rspec
```

### RuboCop

Lint the codebase using:
```bash
bundle exec rubocop
```

---

## Seeding Data

To populate the database with sample data, run:
```bash
rails db:seed
```
