# ---------- Base para Node (instala deps y copia código) ----------
FROM node:22-alpine AS base
WORKDIR /app

# Copiamos sólo package* primero para aprovechar caché
COPY package*.json ./

# Instala dependencias (usa npm ci si tienes package-lock.json)
RUN npm ci

# Copiamos el resto del código
COPY . .

# ---------- Etapa DEV: Vite dev server ----------
FROM base AS dev
ENV NODE_ENV=development
EXPOSE 5173
# Vite necesita escuchar en 0.0.0.0 dentro del contenedor
CMD ["npm", "run", "dev", "--", "--host", "0.0.0.0", "--port", "5173"]

# ---------- Etapa BUILD: genera /dist ----------
FROM base AS build
ENV NODE_ENV=production
RUN npm run build

# ---------- Etapa PROD: Nginx sirviendo /dist ----------
FROM nginx:1.27-alpine AS prod
# Copiamos nuestra config de Nginx
COPY nginx.conf /etc/nginx/conf.d/default.conf
# Copiamos el build de Vite
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
