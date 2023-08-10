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
      <#elseif messageHeader??>
        ${messageHeader}
      <#elseif message.summary??>
        ${message.summary}
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
        <#if message.summary??>
          <p class="instruction">${message.summary}<#if requiredActions??><#list requiredActions>: <b><#items as reqActionItem>${msg("requiredAction.${reqActionItem}")}<#sep>, </#items></b></#list><#else></#if></p>
        <#else>
          <p class="instruction">
            ${kcSanitize(msg("windowCanBeClosed"))?no_esc}
          </p>
        </#if>

        <#if skipLink??>
        <#else>
          <#if pageRedirectUri?has_content>
            <p>
              <a href="${pageRedirectUri}">${kcSanitize(msg("backToApplication"))?no_esc}</a>
            </p>
          <#elseif actionUri?has_content>
            <p>
              <a class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}" href="${actionUri}">${kcSanitize(msg("proceedWithAction"))?no_esc}</a>
            </p>
          </#if>
        </#if>
      </#if>
    </div>
    </#if>
</@layout.registrationLayout>
