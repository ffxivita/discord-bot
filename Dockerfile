FROM node:16-alpine@sha256:fcb03294d3c0695cf9762dec94c0366f08e7a8c6a3c1e062d38c80ac30684d8a as builder
WORKDIR /app
ENV NODE_ENV=development
COPY package*.json ./
COPY tsconfig*.json ./
RUN npm ci
COPY src/ src/
RUN npm run build:typescript
FROM node:16-alpine@sha256:fcb03294d3c0695cf9762dec94c0366f08e7a8c6a3c1e062d38c80ac30684d8a
ENV NODE_ENV=production
COPY --from=builder /app/build ./build
COPY --from=builder /app/node_modules ./node_modules
EXPOSE 3000
CMD ["node", "build/index.js"]
