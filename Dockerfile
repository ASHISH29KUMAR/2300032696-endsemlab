# ---- Build Stage ----
    FROM node:18 AS build

    WORKDIR /app
    
    COPY package*.json ./
    RUN npm install
    
    COPY . .
    RUN npm run build
    
    # ---- Run Stage ----
    FROM nginx:alpine
    
    # Copy built frontend to Nginx html directory
    COPY --from=build /app/dist /usr/share/nginx/html
    
    EXPOSE 80
    
    CMD ["nginx", "-g", "daemon off;"]
    