<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
  <#if section = "header">
    ${msg("returningUserWithoutVerifiedEmailTitle")}
  <#elseif section = "form">
    <#function getEmailAddress>
       <#if (validationErrors)?? && (validationErrors.email)?? >
        <#return validationErrors.email>
      <#elseif (formData)?? && (formData.email)?? >
        <#return formData.email>
      <#else>
        <#return ''>
      </#if>
    </#function>

    <#assign emailAddress=getEmailAddress() />
    <#assign hasValidationErrors=((validationErrors.email)??)?then(true,false) />
    <#assign emailErrorClassname=hasValidationErrors?then(properties.kcFormGroupHasErrorClass,'') />
    <#assign ariaInvalid=hasValidationErrors?then('true','false') />
    <#assign errorMessageRole=hasValidationErrors?then('alert','') />

		<div id="kc-email-text">
      <p>${msg("returningUserWithoutVerifiedEmailText")}</p>
		</div>
		<form class="form-actions" id="kc-provide-plain-email-again-form" action="${url.loginAction}" method="post">
      <div id="hs-email-form-group" class="${properties.kcFormGroupClass!} ${emailErrorClassname}">
        <div class="hds-text-input">
            <label class="hds-text-input__label" for="hs-email">${msg("email")}</label>
            <input class="hds-text-input__input" type="email" name="email" id="hs-email" placeholder="${msg("emailPlaceholder")}" value="${emailAddress}" aria-invalid="${ariaInvalid}"/>
            <span class="hs-error-message hs-email-error-message" role="${errorMessageRole}">${msg("emailError")}</span>
        </div>
      </div>
      <div class="wide-buttons">
			  <button class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonLargeClass!}" id="kc-accept" type="submit" value="accept">${msg("continue")}</button>
        <input type="hidden" name="response" id="kc-response" value="" />
      </div>
    </form>
		<div class="clearfix"></div>
    </#if>
</@layout.registrationLayout>
