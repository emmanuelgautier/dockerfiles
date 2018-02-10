## Development environment target
FROM node as dev-env

WORKDIR /usr/src/app

COPY [ "package*.json", "yarn.lock", "./" ]
RUN yarn install

COPY . .

EXPOSE 3000

ENTRYPOINT [ "./docker-entrypoint.sh" ]

## Build environment target
FROM node as build-env

WORKDIR /usr/src/app

COPY [ "package*.json", "yarn.lock", "./" ]
RUN yarn install --production

COPY . .

CMD [ "yarn", "build" ]

## Production environement target
FROM nginx:alpine as production-env

LABEL MAINTAINER Emmanuel Gautier <docker@emmanuelgautier.fr>

COPY --from=build-env /usr/src/app/build /usr/share/nginx/html

EXPOSE 80
EXPOSE 443
