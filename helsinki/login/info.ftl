<#outputformat "plainText">
<#assign requiredActionsValues><#if requiredActions??><#list requiredActions><#items as reqActionItem>${reqActionItem}<#sep>, </#sep></#items></#list></#if></#assign>
</#outputformat>

<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=false; section>
    <#if section = "header">
      <#if requiredActionsValues == "VERIFY_EMAIL">
        ${kcSanitize(msg("infoVerifyEmailTitle"))?no_esc}
      <#elseif requiredActionsValues == "UPDATE_PASSWORD">
        ${kcSanitize(msg("infoUpdatePasswordTitle"))?no_esc}
      <#else>
        ${kcSanitize(msg("emailVerifiedMessage"))?no_esc}
      </#if>
    <#elseif section = "form">
    <div id="kc-info-message">
      <#if requiredActionsValues == "VERIFY_EMAIL">
        <p class="instruction">${kcSanitize(msg("infoVerifyEmailText"))?no_esc}</p>
        <p>
          <a class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}" href="${actionUri}">${kcSanitize(msg("infoVerifyEmailLinkText"))?no_esc}</a>
        </p>
      <#elseif requiredActionsValues == "UPDATE_PASSWORD">
        <p class="instruction">${kcSanitize(msg("infoUpdatePasswordText"))?no_esc}</p>
        <p>
          <a class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}" href="${actionUri}">${kcSanitize(msg("infoUpdatePasswordLinkText"))?no_esc}</a>
        </p>
      <#else>
        ${kcSanitize(msg("windowCanBeClosed"))?no_esc}
      </#if>
    </div>
    </#if>
</@layout.registrationLayout>
