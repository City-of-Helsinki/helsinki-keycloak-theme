<#outputformat "plainText">
<#assign requiredActionsText><#if requiredActions??><#list requiredActions><#items as reqActionItem>${msg("requiredAction.${reqActionItem}")}<#sep>, </#sep></#items></#list></#if></#assign>
<#assign requiredActionsValues><#if requiredActions??><#list requiredActions><#items as reqActionItem>${reqActionItem}<#sep>, </#sep></#items></#list></#if></#assign>
</#outputformat>

<#import "template.ftl" as layout>
<@layout.emailLayout; section>
  <#if section = "title">
    <#assign title = "genericExecuteActionsSubject" />
    <#if requiredActionsValues == "VERIFY_EMAIL">
      <#assign title = "verifyEmailTitle" />
    <#elseif requiredActionsValues == "UPDATE_PASSWORD">
      <#assign title = "passwordResetSubject" />
    </#if>
    ${kcSanitize(msg(title))?no_esc}
  <#elseif section = "content">
    <#assign bodyHtml = "genericExecuteActionsBodyHtml" />
    <#if requiredActionsValues == "VERIFY_EMAIL">
      <#assign bodyHtml = "verifyEmailBodyHtml" />
    <#elseif requiredActionsValues == "UPDATE_PASSWORD">
      <#assign bodyHtml = "passwordResetBodyHtml" />
    </#if>
    ${kcSanitize(msg(bodyHtml,link, linkExpiration, requiredActionsText, linkExpirationFormatter(linkExpiration)))?no_esc}
  <#elseif section = "footer">
    ${kcSanitize(msg("emailVerificationCodeFooterHtml"))?no_esc}
  </#if>
</@layout.emailLayout>
