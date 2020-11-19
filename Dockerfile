###
# Set up development
FROM node:latest AS development

WORKDIR /code

# copy over package and package-lock
COPY ./package*.json ./

# install dependencies
RUN npm install

# copy over the source code, so we can run the dev server
COPY . .

###
# build
FROM development AS build

RUN npm run build

###
# final stage
FROM alpine:latest AS files-only

COPY --from=build /code/public /public

CMD ["tail", "-f", "/dev/null"]