# ---- Base image ------------------------------------------------------------
FROM node:20-alpine AS base
WORKDIR /app

# ---- Install only what we need --------------------------------------------
# Copy manifest first to leverage Docker layer-cache
COPY package*.json ./
RUN npm i --omit=dev   # production install, smaller image

# ---- Copy source & expose port --------------------------------------------
COPY . .
# server.js defaults to 8080; allow override at runtime
ENV PORT=8080
EXPOSE $PORT

# ---- Start the lightweight Node server ------------------------------------
CMD ["node", "server.js"]
