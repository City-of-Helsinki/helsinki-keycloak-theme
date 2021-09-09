<#macro emailLayout>
<!DOCTYPE html>
<html lang="${msg("emailLangCode")}" xmlns="http://www.w3.org/1999/xhtml" xmlns:o="urn:schemas-microsoft-com:office:office">
  <head>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
      <meta name="viewport" content="width=device-width,initial-scale=1">
      <meta name="x-apple-disable-message-reformatting">
      <title></title>
      <!--[if mso]>
      <noscript>
          <xml>
              <o:OfficeDocumentSettings>
                  <o:PixelsPerInch>96</o:PixelsPerInch>
              </o:OfficeDocumentSettings>
          </xml>
      </noscript>
      <![endif]-->
  </head>
  <body style="margin:0;padding:0;">
      <table role="presentation" style="width:100%;background:#ffffff;color:#1d1d1d;${properties.tableResetStyle}" border="0" cellpadding="0" cellspacing="0">
          <tr>
              <td align="left" valign="top" style="background:url('https://i.ibb.co/XFTzQ4f/koros.png');background-repeat:repeat-x;width:100%;line-height:47px;height:47px;${properties.emptyCellResetStyle}">
                &nbsp;
              </td>
          </tr>
          <tr>
              <td align="left" valign="top" style="line-height:40px;height:40px;${properties.emptyCellResetStyle}">
                  &nbsp;
              </td>
          </tr>
          <tr>
              <td align="left" valign="top" style="${properties.cellPaddingStyle}">
                  <table style="${properties.tableResetStyle}" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                      <td align="left" valign="middle" style="line-height:0px;height:44px;${properties.emptyCellResetStyle}">
                          <img src="https://i.ibb.co/qDmRmpc/${msg("logoImage")}.png" height="44" alt="Logo" style="width:auto;display:block;" >
                      </td>
                      <td align="left" valign="middle" style="height:44px;padding:0px 0px 8px 14px;${properties.fontAdjustmentsTextStyle}font-size:22px;line-height:44px;">
                          ${msg("profile")}
                      </td>
                  </tr>
                  </table>
              </td>
          </tr>
          <tr>
              <td align="left" valign="top" style="${properties.cellPaddingStyle}">
                  <div style="${properties.titleTextStyle}${properties.fontAdjustmentsTextStyle}"><#nested "title"></div>
              </td>
          </tr>
          <tr>
              <td align="left" valign="top" style="${properties.cellPaddingStyle}${properties.contentTextStyle}${properties.fontAdjustmentsTextStyle}">
                  <#nested "content">
              </td>
          </tr>
          <tr>
              <td align="left" valign="top" style="line-height:10px;height:10px;${properties.emptyCellResetStyle}">
                  &nbsp;
              </td>
          </tr>
          <tr>
              <td align="left" valign="top" style="${properties.cellPaddingStyle}${properties.contentTextStyle}${properties.fontAdjustmentsTextStyle}">
                  <div style="${properties.footerBorderStyle}">&nbsp;</div>
                  <#nested "footer">
              </td>
          </tr>
      </table>
  </body>
</html>
</#macro>