# Lab 10 - Deploying Recipe Book Application with Kamal

## Steps Followed
1. **Initial Setup**

- Installed Docker Desktop for Windows with WSL2 integration
- Configured Kamal in the Rails project
- Created `.kamal/secrets` file for environment variables
- Set up Docker Hub credentials

2. **Configuration Files**
`config/deploy.yml`:

- Configured service name: `recipe_book_app`
- Set Docker Hub image: `oscarca8/recipe_book_app`
- Added server IP: `164.90.152.199`
- Configured PostgreSQL accessory
- Set up environment variables (RAILS_MASTER_KEY, DATABASE_URL)

`.kamal/secrets`:

bash
```
KAMAL_REGISTRY_PASSWORD=<docker_token>
RAILS_MASTER_KEY=$(cat config/master.key)
POSTGRES_PASSWORD=<password>
DATABASE_URL=postgresql://recipe_book:<password>@recipe_book_app-db:5432/recipe_book_app_production
```

3. **Database Configuration**

- Added PostgreSQL accessory to `deploy.yml`
- Configured multi-database setup for Rails 8 (primary, cache, queue, cable)
- Set up DATABASE_URL environment variable


## Issues Encountered and Solutions
### Issue 1: Missing `builder.ssh` Configuration

**Error**: `builder/ssh: should be a string`

**Solution**: Changed `config/deploy.yml` builder section:

yaml
```
builder:
  arch: amd64
  ssh: default
```
### Issue 2: SSH Agent Not Running

**Error**: `invalid empty ssh agent socket: make sure SSH_AUTH_SOCK is set`

**Solution**:

bash
```
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
```

Alternatively, removed `ssh:` line from builder config since building locally.

### Issue 3: Docker Hub Authentication Failed

**Error**: `unauthorized: incorrect username or password`

**Solution**:

- Created Docker Hub Personal Access Token
- Updated `.kamal/secrets` with the token
- Tested login: docker login -u oscarca8

### Issue 4: Missing Service Label in Docker Image

**Error**: `Image is missing the 'service' label`

**Solution**: Added to Dockerfile:

dockerfile
```
LABEL service="recipe_book_app"
```

### Issue 5: SQLite Gem Not in Production Bundle
**Error:** `sqlite3 is not part of the bundle`

**Solution:** Switched to PostgreSQL which was already in Gemfile:
- Configured PostgreSQL accessory in `deploy.yml`
- Set correct DATABASE_URL format

### Issue 6: Invalid DATABASE_URL Format
**Error:** `bad URI (is not URI?): DATABASE_URL=postgres://...`

**Multiple fixes:**
1. Removed duplicate `DATABASE_URL=` prefix in value
2. Changed scheme from `postgres://` to `postgresql://`
3. Added port `:5432` to URL
4. Fixed database name to match `database.yml`: `recipe_book_app_production`

**Final working format:**

secrets
```
postgresql://recipe_book:password@recipe_book_app-db:5432/recipe_book_app_production
```

### Issue 7: Docker Buildx Mount Error
**Error**: `invalid mount config for type "bind": bind source path does not exist`

**Solution**:
bash
```
docker buildx rm kamal-local-docker-container
docker buildx use default
```

### Issue 8: Network Connectivity Issues (WSL)
**Error**: `Temporary failure in name resolution`

**Solution**:
- Restarted WSL: `wsl --shutdown` (in Windows PowerShell)
- Fixed WSL DNS configuration
- Restarted Docker Desktop

### Issue 9: Git Repository Divergence on Server
**Error**: `fatal: Need to specify how to reconcile divergent branches`

**Solution**:
bash
```
ssh root@164.90.152.199
cd ~/lab_7
git reset --hard origin/master
```

### Issue 10: Missing Solid Queue Tables
**Error**: `PG::UndefinedTable: ERROR: relation "solid_queue_recurring_tasks" does not exist`

**Status**: Deleted
- Solid Queue 1.2.1 doesn't include migration files
- Need to generate tables through db:prepare or alternative method


## Key Learnings

1. Environment Variables: Proper formatting is critical - no duplicate prefixes, correct URI schemes
2. Docker Integration: WSL2 requires Docker Desktop with proper integration enabled
3. Database URLs: PostgreSQL URLs need explicit port and correct scheme (`postgresql://` not `postgres://`)
4. Kamal Secrets: The .kamal/secrets file must have exact formatting with no extra spaces
5. Git Workflows: Server and local repositories must stay in sync
6. Rails 8 Changes: Solid Queue integration has changed from previous versions


## Current Status

- (ready) Docker Desktop installed and configured
- (ready) Kamal configuration completed
- (ready) PostgreSQL database deployed
- (ready) Docker image built and pushed successfully
- (ready) Application deployed to DigitalOcean
- (ready) Solid Queue disabled (can be enabled later if needed)



## Accessing the Application
- Production URL: http://164.90.152.199
- Available Features:

- User registration and authentication (Devise)
- Recipe creation and management
- Recipe listing and viewing
- Full CRUD operations on recipes


## Useful Commands
bash
```
# Deploy
bin/kamal setup                    # Initial setup
bin/kamal deploy                   # Deploy application
bin/kamal deploy --skip-push       # Deploy without building

# Debugging
bin/kamal app logs                 # View application logs
bin/kamal app exec 'command'       # Run command in container
ssh root@164.90.152.199            # SSH to server

# Docker
docker ps                          # List running containers
docker logs container_name         # View container logs
docker buildx ls                   # List builders
```

**Deployment Time**: ~4 hours (including troubleshooting)
**Server IP**: http://164.90.152.199
**Date**: November 2, 2025
