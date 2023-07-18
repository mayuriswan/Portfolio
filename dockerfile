# Stage 1: Build the Angular app
FROM node:14 as build-stage
WORKDIR /app
COPY package*.json ./
RUN npm config set registry="http://registry.npmjs.org/"
COPY . .
RUN npm run build -- --output-path=./dist/out

# Stage 2: Create a lightweight image with the built app
FROM nginx:alpine
COPY --from=build-stage /app/dist/out/ /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
