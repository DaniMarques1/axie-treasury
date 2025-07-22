# Dockerfile

# 1) Use a Debian‑slim base instead of Alpine
FROM node:20-slim AS builder  
WORKDIR /app

# 2) Install deps
COPY package*.json ./
RUN npm ci

# 3) Copy source & build
COPY . .
RUN npm run build

# 4) Prune devDependencies for smaller final image
RUN npm prune --production

# 5) Runtime image
FROM node:20-slim
WORKDIR /app
COPY --from=builder /app ./
CMD ["npm", "start"]
