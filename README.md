# one-piece-keycloak-theme

Tema Keycloak custom ("onepiece") per le pagine gestite da Keycloak stesso — login, verifica
email, aggiornamento password/profilo, email transazionali — così che restino coerenti con
l'identità visiva "Sunny Deck" del resto dell'app invece di mostrare il tema di default.
Eredita da `parent=keycloak`: nessun template `.ftl` copiato o modificato, solo CSS,
`theme.properties` e i bundle di messaggi (`it`/`en`) sotto `theme/onepiece/`. Motivazione e
alternative scartate: `onepiece-infrastructure/docs/adr/0010-custom-keycloak-theme.md`.

Non è un'applicazione con un proprio processo/server locale: è un albero di file statici
copiato dentro l'immagine ufficiale di Keycloak (`Dockerfile`), che li serve.

## Sviluppo locale

```bash
./scripts/build-image.sh   # build one-piece-keycloak-theme:local, resta nel Docker daemon
```

Per vedere una modifica riflessa nel cluster `kind` locale (repo
`onepiece-infrastructure`):

```bash
kind load docker-image one-piece-keycloak-theme:local --name onepiece
helmfile sync -l name=keycloak   # riapplica la release, che riavvia il pod con l'immagine nuova
```

poi, con `kubectl port-forward svc/keycloak-http -n auth 8080:8080` attivo, apri
`http://localhost:8080/realms/onepiece/account` (o avvia un login reale dall'app,
`http://localhost:4180`) per vedere le pagine col tema aggiornato. Non c'è modo di
"hot reload" i template lato Keycloak: ogni modifica richiede questo giro
build immagine → `kind load` → riavvio del pod.

## Struttura

```
theme/onepiece/
├── login/            # login, verifica email, reset/aggiorna password, aggiorna profilo
│   ├── theme.properties
│   ├── messages/     # messages_it.properties, messages_en.properties
│   └── resources/    # CSS, immagini
└── email/            # email transazionali (invito, verifica, reset)
    ├── theme.properties
    ├── html/
    ├── messages/
    └── resources/
```

## CI

`.github/workflows/ci.yml` pubblica l'immagine multi-arch su GHCR
(`ghcr.io/one-piece-api/keycloak-theme`) — stessa forma della CI di `user-frontend`/
`user-service` (build per piattaforma via digest, merge del manifest, notifica a
`onepiece-infrastructure` per il deploy remoto).
