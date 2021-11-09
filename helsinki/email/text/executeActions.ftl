<#ftl output_format="plainText">
<#assign requiredActionsText><#if requiredActions??><#list requiredActions><#items as reqActionItem>${msg("requiredAction.${reqActionItem}")}<#sep>, </#sep></#items></#list></#if></#assign>
<#assign requiredActionsValues><#if requiredActions??><#list requiredActions><#items as reqActionItem>${reqActionItem}<#sep>, </#sep></#items></#list></#if></#assign>
<#assign bodyText = "genericExecuteActionsBody" />
<#if requiredActionsValues == "VERIFY_EMAIL">
  <#assign bodyText = "verifyEmailBody" />
<#elseif requiredActionsValues == "UPDATE_PASSWORD">
  <#assign bodyText = "passwordResetBody" />
</#if>
<#assign lines = msg(bodyText, link, linkExpiration, requiredActionsText, linkExpirationFormatter(linkExpiration))?split("\\n") />
<#list lines as line>
${line}
</#list>

${msg("emailVerificationCodeFooter")}