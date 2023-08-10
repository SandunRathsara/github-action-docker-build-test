# Use lts alpine version to build and run the API
FROM node:lts-alpine3.18 AS builder

# Create app directory
WORKDIR /app

# Copy the necessary files to install node modules and generate prisma types
COPY package.json ./
COPY yarn.lock ./

# Skip puppeteer download
ENV PUPPETEER_SKIP_DOWNLOAD=true

# Install app dependencies
RUN yarn install

# Copy the source code
COPY . .

# Build the API
RUN yarn build

FROM node:lts-alpine3.18

# Create production app
WORKDIR /app

# Copy the necessary built artifacts
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package.json ./
COPY --from=builder /app/yarn.lock ./
COPY --from=builder /app/dist ./dist

# Expose the port from docker container
EXPOSE 3000

# Start the API
CMD ["yarn", "start:prod"]