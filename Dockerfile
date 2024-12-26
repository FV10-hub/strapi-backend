#FROM node:18.20.5-alpine
FROM node:18-alpine
# Installing libvips-dev for sharp Compatibility
RUN apk update && apk add --no-cache build-base gcc autoconf automake zlib-dev libpng-dev nasm bash vips-dev git
ARG NODE_ENV=production
ENV NODE_ENV=${NODE_ENV}

WORKDIR /opt/
COPY ./package.json ./
RUN yarn global add node-gyp
RUN yarn config set network-timeout 800000 -g && yarn install
ENV PATH /opt/node_modules/.bin:$PATH

# Configurar sharp para construir desde el origen
#ENV npm_config_build_from_source=true

WORKDIR /opt/app
COPY ./ .
#RUN chown -R node:node /opt/app
#USER node
RUN yarn add sharp
RUN yarn build
EXPOSE 1337
CMD ["yarn", "develop"]
