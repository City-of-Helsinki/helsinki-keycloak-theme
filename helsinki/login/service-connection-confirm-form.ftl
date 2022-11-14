<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
    <#if section = "header">
      ${msg("weUseInformationTitle")}
    <#elseif section = "form">
      <p>${msg("serviceDataUsageListTitleOldUser", serviceName)?no_esc}</p>
      <ul class="checked-list content-before-buttons">
        <#list serviceAllowedDataFields as item>
          <li>${item}</li>
        </#list>
      </ul>
      <form id="kc-service-connection-confirm-form" action="${url.loginAction}" method="post">
          <div class="wide-buttons">
              <button class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonLargeClass!}" id="kc-accept" type="submit" name="response" value="accept">${msg("profileAcceptButtonText")}</button>
              <button class="${properties.kcButtonClass!} ${properties.kcButtonDefaultClass!} ${properties.kcButtonLargeClass!}" id="kc-decline" type="submit" name="response" value="decline">${msg("profileDeclineButtonText")}</button>
          </div>
      </form>
      <div class="clearfix"></div>
    </#if>
</@layout.registrationLayout>