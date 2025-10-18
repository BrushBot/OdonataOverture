# AGENTS.md — Unified AI Instructions for this Rails 8 Application

This file is the single source of truth for AI coding assistants (Cursor, GitHub Copilot, etc.). It consolidates all repo rules and replaces separate rules files.

## Project Context
- Rails: 8.0.3
- Ruby: 3.4.6
- Database: SQLite3
- Frontend: Hotwire (Turbo + Stimulus)
- Asset pipeline: Propshaft
- Caching/Jobs/Cable: Solid Cache / Solid Queue / Solid Cable
- Web server: Puma with Thruster
- Testing: Minitest
- Code style: RuboCop Rails Omakase

## Quick Reference for Common Tasks

### Creating new files
- Models: place in `app/models/`; keep business logic lean; share behavior via `app/models/concerns/`.
- Controllers: place in `app/controllers/`; use RESTful actions (`index`, `show`, `new`, `create`, `edit`, `update`, `destroy`).
- Views: place in `app/views/` mirroring controller structure; use partials and helpers.
- Services: place in `app/services/`; expose a single `.call` entrypoint.
- Tests: place in `test/` mirroring app structure; use fixtures in `test/fixtures/`.

### Writing code
- Favor Rails conventions; prefer `rails generate` over manual boilerplate.
- Always use strong parameters in controllers.
- Implement validations and associations in models.
- Prefer ActiveRecord query methods over raw SQL.
- Use safe navigation (`&.`), keyword args, and modern Ruby syntax.
- Follow RuboCop Rails Omakase; 2-space indentation; prefer single quotes unless interpolating.

### Hotwire/Turbo
- Use `turbo_frame_tag` for independently updating sections.
- Use Turbo Streams (`turbo_stream` helpers, `broadcast_*`) for dynamic updates.
- Place Stimulus controllers in `app/javascript/controllers/`; follow `data-controller`/`data-action` conventions.

### Security
- Always use strong params: `params.require(:model).permit(:attrs)`.
- Ensure CSRF protection; configure CSP in `config/initializers/content_security_policy.rb`.
- Use authentication (`before_action`) and authorization checks consistently.

## General Guidelines
- Follow convention over configuration; keep controllers skinny; move complex logic to models/services.
- Use I18n for all user-facing text.
- Use `Time.current`; prefer `present?`/`blank?`.
- Prefer `includes`/`preload` to avoid N+1 queries.
- Favor Minitest for coverage; test happy paths and edge cases.

## Contextual Rules

### Models (`app/models/**/*.rb`)
- Limit files to ≤150 lines; extract to services/concerns as needed.
- Use scopes for common queries; prefer `find_by` over `where.first`.
- Define validations and associations; keep persistence concerns cohesive.

### Controllers (`app/controllers/**/*.rb`)
- Handle HTTP flow only; avoid business logic.
- Use `before_action` for setup/auth; respond with proper status codes.
- Use `respond_to` blocks for multiple formats; redirect on success, render on validation errors.

### Services (`app/services/**/*.rb`)
- Single responsibility with public `.call` method.
- Return structured results in place of bare booleans where helpful.

### Views (`app/views/**/*.erb`)
- Keep logic minimal; push formatting to helpers/components; use partials.
- Use layouts in `app/views/layouts/`; manage regions with `content_for`/`yield`.

### JavaScript (`app/javascript/controllers/**/*.js`)
- Descriptive Stimulus controller names; minimal imperative JS; focus on behavior.

### Tests (`test/**/*.rb`)
- Descriptive test names: `test "should do X"`.
- Use fixtures; keep tests independent and fast; mock external services.

## Naming Conventions
- Models: singular PascalCase (`User`, `OrderItem`).
- Controllers: plural PascalCase with `Controller` suffix (`UsersController`).
- Views: directories/actions in snake_case (`users/index.html.erb`).
- Tables/columns: plural snake_case tables; snake_case columns.
- Routes: RESTful resource routes by default.

## Routing Conventions
- Use `resources` for CRUD; nest when appropriate.
- Use `member`/`collection` for custom actions; prefer explicit verbs over `match`.

## Security Rules
- Strong parameters everywhere; never use raw `params[...]` for mass assignment.
- CSRF tokens in forms; `protect_from_forgery` in `ApplicationController` (Rails default).
- Authorization checks around protected routes; rely on `current_user` helpers.

## Performance Rules
- Eager load associations to avoid N+1s.
- Add indexes for frequently queried columns.
- Prefer `pluck` for single-attribute reads; use `find_each` for large batches.
- Consider `counter_cache` for association counts.

## Database Conventions
- Migrations: descriptive names; reversible; include indexes; use `null: false` and sensible defaults.
- Schema: timestamps; use `references` for FKs; pick appropriate data types; enforce constraints.

## Error Handling
- Controllers: `rescue_from` common exceptions; log appropriately; return correct HTTP statuses.
- Models: use validations; add custom validation methods with clear `errors.add` messages.

## Development Workflow
- Git: descriptive, focused commits; prefer conventional commits; use feature branches.
- Code review: verify conventions, security, tests, and performance implications.

## AI Behavior Guidelines
- Briefly explain applied Rails conventions when generating code.
- Avoid outdated APIs (e.g., `update_attributes`, `before_filter`).
- Prefer `&&`/`||` over `and`/`or`; prefer `unless` over `if !condition` where clear.
- Use trailing commas in multi-line arrays/hashes.

## Anti‑patterns
- Business logic in controllers; large controller methods; raw SQL without necessity.
- Skipping CSRF; mass assignment via raw `params`.
- N+1 queries; `eval`/`instance_eval`; `render :text` (use `render plain:`).

## Sources
- Rails Guides (`https://guides.rubyonrails.org/`)
- Rails Doctrine (`https://rubyonrails.org/doctrine`)
- Rails API Docs (`https://api.rubyonrails.org/`)
- Rails Security Guide (`https://guides.rubyonrails.org/security.html`)
- Rails Testing Guide (`https://guides.rubyonrails.org/testing.html`)
- Hotwire Docs (`https://hotwired.dev/`)
- RuboCop Rails Omakase (`https://github.com/rails/rubocop-rails-omakase`)

## Tool Notes
- Cursor and GitHub Copilot both read this `AGENTS.md`. No other rules files are required.
