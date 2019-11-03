FROM node:alpine

# Also exposing VSCode debug ports
EXPOSE 8003

RUN \
  apk add --no-cache python make g++ && \
  apk add vips-dev fftw-dev --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/community --repository http://dl-3.alpinelinux.org/alpine/edge/main && \
  rm -fR /var/cache/apk/*

RUN npm install -g gatsby-cli yarn

WORKDIR /app
COPY ./package.json .
# RUN yarn install && yarn cache clean
# RUN rm -rf node_modules/sharp && npm install --arch=x64 --platform=linux --target=8.10.0 sharp
# RUN rm -f package-lock.json && rm -rf node_modules && npm install
RUN npm install
COPY . .
CMD ["yarn", "develop","-p", "8003", "-H", "0.0.0.0"]
# CMD ["gatsby", "develop", "-p", "8003"]