FROM node:alpine as builder
WORKDIR /usr/src/app
COPY package.json ./
RUN npm install
COPY ./ ./
RUN npm run build

FROM nginx
RUN rm -rf /etc/nginx/conf.d
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf

COPY --from=builder --chown=user:group /usr/src/app/build /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
