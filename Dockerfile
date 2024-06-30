    # Initiate a container to build the application in.
    FROM node:16-alpine AS build
    ENV NODE_ENV=build
    ENV NODE_OPTIONS=--max_old_space_size=4096
    WORKDIR /usr/src/app

    # Copy the package.json into the container.
    COPY package*.json ./
    COPY yarn.lock ./

    # Install the dependencies required to build the application.
    RUN npm install yarn
    RUN yarn install

    COPY . .
    RUN echo "Current directory" && pwd

    RUN ls -la
    RUN echo "ENV FILE CHECK"
    RUN cat .env
    # Build the application.
    RUN npm run build

    # # Uninstall the dependencies not required to run the built application.
    # RUN npm prune --production

    # Debugging step: List contents of the directory to verify if dist folder is present.
    RUN ls -l /usr/src/app

    # Initiate a new container to run the application in.
    # FROM node:16-alpine
    # ENV NODE_ENV=production
    # WORKDIR /usr/src/app

    # Copy everything required to run the built application into the new container.
    # COPY --from=build /usr/src/app/package*.json ./
    # COPY --from=build /usr/src/app/yarn* ./
    # COPY --from=build /usr/src/app/node_modules/ ./node_modules/
    # COPY --from=build /usr/src/app/dist ./dist
    # RUN npm install -g http-server
    # COPY package*.json ./
    # COPY yarn.lock ./

    # RUN yarn install --prod
    # RUN rm package*.json yarn.lock
    # Expose the web server's port.

    FROM nginx:stable-alpine as production-stage
    WORKDIR /usr/src/app
    COPY --from=build /usr/src/app/dist /usr/src/app
    COPY nginx.conf /etc/nginx/nginx.conf
