<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
    <#if section = "header">
      ${msg("serviceConnectionTitle")}
    <#elseif section = "form">
		<div id="kc-terms-text">
            <p>${msg("serviceConnectionText")?no_esc}</p>
		</div>
        <div id="kc-terms-text">
            <p>${msg("serviceConnectionTextFieldsInfo")?no_esc}</p>
        </div>
        <div id="kc-terms-text">
            <p>${msg("serviceConnectionTextName")?no_esc}</p>
            <p>${msg("serviceConnectionTextAddress")?no_esc}</p>
            <p>${msg("serviceConnectionTextPhone")?no_esc}</p>
        </div>
		<form class="form-actions" id="kc-update-service-connection-confirm-form" action="${url.loginAction}" method="post">
            <div class="wide-buttons">
                <button class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonLargeClass!}" id="kc-accept" type="button" value="accept">${msg("profileAcceptButtonText")}</button>
                <button class="${properties.kcButtonClass!} ${properties.kcButtonDefaultClass!} ${properties.kcButtonLargeClass!}" id="kc-decline" type="button" value="decline">${msg("profileDeclineButtonText")}</button>
                <input type="hidden" name="response" id="kc-response" value="decline" />
            </div>
        </form>
		<div class="clearfix"></div>
    </#if>
</@layout.registrationLayout>
