FROM node:16-alpine as builder

USER node

RUN mkdir -p /home/node/app
WORKDIR /home/node/app

COPY --chown=node:node package.json .
COPY --chown=node:node package-lock.json .
RUN npm ci

COPY --chown=node:node . .
RUN npm run build

FROM nginx

COPY --chown=node:node --from=builder /home/node/app/build /usr/share/nginx/html