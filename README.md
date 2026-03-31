# Feedco API – Dokumentace (Swagger UI)

Statický hosting API dokumentace pomocí Swagger UI a Nginx.
Žádný build step, žádný backend – jen HTML + YAML.

## Struktura

```
feedco-docs/
├── public/
│   ├── index.html       # Swagger UI
│   └── openapi.yaml     # OpenAPI 3.0.3 spec (udržuj ručně)
├── nginx.conf           # Nginx konfigurace
├── Dockerfile
├── docker-compose.yml
└── README.md
```

## Lokální spuštění

```bash
docker compose up --build
```

Dokumentace poběží na [http://localhost:8080](http://localhost:8080).

## Aktualizace specifikace

1. Přepiš `public/openapi.yaml` novou verzí.
2. Nginx načítá soubor při každém requestu (bind mount) – žádný restart není potřeba.
3. Pokud měníš `index.html` nebo `nginx.conf`, proveď rebuild:

```bash
docker compose up --build
```

## Nasazení na server (reverse proxy)

Kontejner poslouchá na portu 80. Před něj postav reverse proxy (Nginx, Caddy, Traefik):

```nginx
# Příklad Nginx reverse proxy pro docs.feedco.cz
server {
    listen 443 ssl;
    server_name docs.feedco.cz;

    location / {
        proxy_pass http://127.0.0.1:8080;
    }
}
```

## Alternativní platformy

Kontejner lze nasadit beze změn na **Railway**, **Fly.io** nebo **Coolify** – stačí propojit repo a nastavit port 80.
