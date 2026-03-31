# Feedco API dokumentace – statický hosting přes Nginx
FROM nginx:alpine

# Nginx konfigurace
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Statické soubory (index.html + openapi.yaml)
COPY public/ /usr/share/nginx/html/

EXPOSE 80
