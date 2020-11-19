# Svelte Client for En to De Translation Project
This is the svelte front end for the ENDE Translation Project.

## Translation API
This client makes requests to the `/api/translate/en-to-de` endpoint which gets proxied to `http://translation-server:5000/translate/en-to-de`. This client container assumes that it is linked to a service called `translation-server` with the translation server running on port `5000`.

## NGINX
This container serves the client application with NGINX, and proxy passes requests to /api.