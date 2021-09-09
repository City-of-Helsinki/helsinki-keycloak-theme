<#import "template.ftl" as layout>
<@layout.emailLayout; section>
  <#if section = "title">
      ${kcSanitize(msg("emailVerificationCodeTitle"))?no_esc}
  <#elseif section = "content">
    ${kcSanitize(msg("emailVerificationBodyCodeHtml"))?no_esc}
    <p style="font-size:28px;"><b>${code}</b></p>
  <#elseif section = "footer">
    ${kcSanitize(msg("emailVerificationCodeFooterHtml"))?no_esc}
  </#if>
</@layout.emailLayout>
