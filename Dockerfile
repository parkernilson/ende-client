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
# production
FROM nginx:stable AS production

# overwrite nginx default config
COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf

# transfer the public files from the built svelte app to the public directory of the nginx server
COPY --from=build /code/public/. /usr/share/nginx/html/.

RUN chown nginx.nginx /usr/share/nginx/html/ -R