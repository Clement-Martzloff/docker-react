FROM node:16-alpine as builder

RUN mkdir -p /home/node/app

WORKDIR /home/node/app

COPY package.json .
COPY package-lock.json .

RUN npm ci

COPY . .

RUN npm run build

USER node

FROM nginx

COPY --from=builder /home/node/app/build /usr/share/nginx/html

EXPOSE 80

USER nginx
