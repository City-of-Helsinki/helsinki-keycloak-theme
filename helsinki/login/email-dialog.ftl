<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
    <#if section = "header">
    We need your email
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
    <#assign emailErrorClassname=((validationErrors.email)??)?then(properties.kcFormGroupHasErrorClass,'') />
    
		<div id="kc-email-text">
      <p>Give me your email</p>
      <#if msg("securitySideNote") != ''>
        <span class="hs-side-note">${msg("securitySideNote")}</span>
      </#if>
		</div>
		<form class="form-actions" id="kc-email-dialog-form" action="${url.loginAction}" method="post">
      <div id="hs-email-form-group" class="${properties.kcFormGroupClass!} ${emailErrorClassname}">
        <div class="hds-text-input" id="hs-email-form-group" class="${properties.kcFormGroupClass!}">
            <label class="hds-text-input__label" for="hs-email">${msg("emailLabel")}</label>
            <input class="hds-text-input__input" type="email" name="email" id="hs-email" placeholder="${msg("emailPlaceholder")}" value="${emailAddress}"/>
            <span class="hs-error-message" role="alert">${msg("emailError")}</span>
        </div>
      </div>
      <div class="wide-buttons">
			  <button class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonLargeClass!}" id="kc-accept" type="submit" value="accept">${msg("profileAcceptButtonText")}</button>
			  <button class="${properties.kcButtonClass!} ${properties.kcButtonDefaultClass!} ${properties.kcButtonLargeClass!}" id="kc-decline" type="submit" value="decline">${msg("profileDeclineButtonText")}</button>
        <input type="hidden" name="response" id="kc-response" value="" />
      </div>
    </form>
		<div class="clearfix"></div>
    </#if>
</@layout.registrationLayout>
