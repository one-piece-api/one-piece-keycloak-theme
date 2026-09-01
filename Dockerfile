# syntax=docker/dockerfile:1
# Immagine ufficiale Keycloak (nessun rebuild della base, solo un tema
# aggiunto sopra) - stessa versione usata in
# onepiece-infrastructure/keycloak/values-keycloakx.yaml.
FROM quay.io/keycloak/keycloak:26.6.4

# --chown=1000:0: stessa convenzione UID/GID arbitrario (root-group,
# world-readable) usata dall'immagine base, cosi' il tema resta leggibile
# anche se il runtime gira con un UID diverso (OpenShift-style).
COPY --chown=1000:0 theme/onepiece /opt/keycloak/themes/onepiece
