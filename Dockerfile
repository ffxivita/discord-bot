FROM node:16-alpine@sha256:a1f9d027912b58a7c75be7716c97cfbc6d3099f3a97ed84aa490be9dee20e787 as builder
WORKDIR /app
ENV NODE_ENV=development
COPY package*.json ./
COPY tsconfig*.json ./
RUN npm ci
COPY src/ src/
RUN npm run build:typescript
FROM node:16-alpine@sha256:a1f9d027912b58a7c75be7716c97cfbc6d3099f3a97ed84aa490be9dee20e787
ENV NODE_ENV=production
COPY --from=builder /app/build ./build
COPY --from=builder /app/node_modules ./node_modules
EXPOSE 3000
CMD ["node", "build/index.js"]
