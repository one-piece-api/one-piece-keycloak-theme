<#-- Wrapper HTML condiviso da tutte le email (verifica, reset password,
     esecuzione azioni richieste, ...): nel tema "base" e' un <html><body>
     vuoto senza alcuno stile. Qui aggiungiamo intestazione, card e piede
     pagina brandizzati "Sunny Deck"; i singoli *.ftl per-messaggio (non
     copiati, ereditati da "base") continuano a passare qui dentro solo il
     corpo del messaggio via <#nested>, gia' passato per kcSanitize - da li'
     escono solo tag semplici (h2, p, b, a[href], ...), niente class/style:
     per questo li targettizziamo per nome di tag dentro .op-email-content
     invece che per classe, stesso principio del CSS del tema login che si
     aggancia al markup generato da Keycloak senza duplicarne i template.

     ${url.resourcesUrl} punta alle risorse statiche di *questo* theme type
     (email), risolto da Keycloak con Theme.Type.EMAIL - stesso meccanismo
     con cui il tema login serve logo.png e denden.png (vedi
     ../../login/resources/css/onepiece.css): per questo le stesse immagini
     sono duplicate in resources/img/ anche qui, Keycloak non condivide gli
     asset fra theme type diversi. -->
<#macro emailLayout>
<html lang="${locale.language}" dir="${(ltr)?then('ltr','rtl')}">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>One Piece API</title>
<style>
  body { margin: 0; padding: 0; background: #eef1fb; font-family: 'Nunito', Verdana, Arial, sans-serif; color: #1c2b3a; }
  .op-email-wrapper { width: 100%; background: #eef1fb; padding: 32px 16px; }
  .op-email-card { max-width: 560px; margin: 0 auto; background: #ffffff; border-radius: 16px; border: 1px solid #cdd6ef; }
  .op-email-header { background: #1a2360; padding: 24px 32px; text-align: center; border-radius: 16px 16px 0 0; }
  .op-email-logo { width: 220px; height: auto; }
  .op-email-content { padding: 32px; font-size: 16px; line-height: 1.6; }
  .op-email-content h1, .op-email-content h2, .op-email-content h3 { font-family: 'Baloo 2', Georgia, serif; color: #1a2360; font-size: 20px; margin: 0 0 16px; }
  .op-email-content p { margin: 0 0 16px; }
  .op-email-content b, .op-email-content strong { color: #1a2360; }
  .op-email-content a { display: inline-block; background: #ffd23f; color: #123243 !important; font-weight: 700; text-decoration: none !important; padding: 12px 28px; border-radius: 999px; font-family: 'Baloo 2', Georgia, serif; }
  .op-email-footer { padding: 20px 32px 28px; text-align: center; font-size: 13px; color: #4a6a7c; }
  .op-email-denden { width: 22px; height: 36px; vertical-align: middle; margin-right: 8px; }
</style>
</head>
<body>
<div class="op-email-wrapper">
  <table role="presentation" width="100%" cellpadding="0" cellspacing="0" border="0">
    <tr>
      <td align="center">
        <table role="presentation" class="op-email-card" width="560" cellpadding="0" cellspacing="0" border="0">
          <tr>
            <td class="op-email-header">
              <img class="op-email-logo" width="220" height="59" src="${url.resourcesUrl}/img/logo.png" alt="One Piece API">
            </td>
          </tr>
          <tr>
            <td class="op-email-content">
              <#nested>
            </td>
          </tr>
          <tr>
            <td class="op-email-footer">
              <img class="op-email-denden" width="22" height="36" src="${url.resourcesUrl}/img/denden.png" alt="">${msg("emailFooterTagline")}
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</div>
</body>
</html>
</#macro>
