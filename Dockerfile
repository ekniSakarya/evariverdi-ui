# ===== STAGE 1: Build =====
FROM node:20-alpine AS builder

WORKDIR /app

# package.json ve lock dosyalarını kopyala
COPY app/package*.json ./

# Bağımlılıkları yükle
RUN npm ci

# Kaynak kodu kopyala
COPY app/ .

# Production build
RUN npm run build

# ===== STAGE 2: Serve =====
FROM nginx:alpine

# Nginx konfigürasyonunu kopyala
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Build çıktısını nginx'e kopyala
COPY --from=builder /app/dist /usr/share/nginx/html

# 8084 portunu aç
EXPOSE 8084

# Nginx'i başlat
CMD ["nginx", "-g", "daemon off;"]
