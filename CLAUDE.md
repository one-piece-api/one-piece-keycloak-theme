# one-piece-keycloak-theme

Keycloak theme "onepiece" (login and e-mail), Sunny Deck look. Inherits from `parent=keycloak`: CSS, `theme.properties` and message bundles only, no copied `.ftl` templates. Rationale: `onepiece-infrastructure/docs/adr/0010-custom-keycloak-theme.md`. Structure and setup: `README.md`. UI rules: `../.claude/rules/ui.md`.

```bash
./scripts/build-image.sh
kind load docker-image one-piece-keycloak-theme:local --name onepiece
# from onepiece-infrastructure:
helmfile sync -l name=keycloak
```

- No hot reload: every change needs build → `kind load` → pod restart; check on `http://localhost:8080/realms/onepiece/account` or through a real login on `http://localhost:4180`.
- Every message exists in `messages_it.properties` and `messages_en.properties` (skill `text-review` for wording).
