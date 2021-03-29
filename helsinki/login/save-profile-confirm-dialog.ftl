<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
    <#if section = "header">
      ${msg("profileHeader")}
    <#elseif section = "form">
		<div id="kc-terms-text">
      ${msg("profileTermsText")?no_esc}
      <#list msg("collectedUserData")?split(", ")>
          <div class="checked-list-title">${msg("userDataListTitle")}</div>
          <ul class="checked-list">
          <#items as dataItem>
            <li>${dataItem}</li>
          </#items>
          </ul>
      </#list>
		</div>
		<form class="form-actions" id="kc-create-profile-form" action="${url.loginAction}" method="post">
      <div id="hs-email-form-group" class="${properties.kcFormGroupClass!}">
        <div class="hds-text-input" id="hs-email-form-group" class="${properties.kcFormGroupClass!}">
            <label class="hds-text-input__label" for="hs-email">${msg("emailLabel")}</label>
            <input class="hds-text-input__input" type="email" name="email" id="hs-email" placeholder="${msg("emailPlaceholder")}"/>
            <span class="hs-error-message" role="alert">${msg("emailError")}</span>
        </div>
      </div>
      <div id="hs-acknowledgements-form-group" class="${properties.kcFormGroupClass!}">
        <div class="hds-checkbox">
            <input class="hds-checkbox__input" type="checkbox" name="acknowledgements" id="hs-acknowledgements" />
            <label class="hds-checkbox__label" for="hs-acknowledgements">${msg("doAcknowledgeResources", kcSanitize(msg("doAcknowledgeResourcesPrivacyPolicyLink")), kcSanitize(msg("doAcknowledgeResourcesyDataProtectionLink")), 'target="_blank" rel="noopener noreferrer"')?no_esc}</label>
        </div>
      </div>
      <div class="wide-buttons">
			  <button class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonLargeClass!}" id="kc-accept" type="button" value="accept">${msg("profileAcceptButtonText")}</button>
			  <button class="${properties.kcButtonClass!} ${properties.kcButtonDefaultClass!} ${properties.kcButtonLargeClass!}" id="kc-decline" type="button" value="decline">${msg("profileDeclineButtonText")}</button>
        <input type="hidden" name="response" id="kc-response" value="" />
      </div>
    </form>
		<div class="clearfix"></div>
    </#if>
</@layout.registrationLayout>
