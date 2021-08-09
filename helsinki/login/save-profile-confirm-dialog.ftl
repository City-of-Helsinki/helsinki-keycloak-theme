<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
    <#if section = "header">
      ${msg("profileHeader")}
    <#elseif section = "form">

    <#function shouldCheckBoxBeChecked>
      <#if (validationErrors)?? && (validationErrors.acknowledgements)??>
        <#return false>
      <#elseif (formData)?? && (formData.acknowledgements)??>
        <#return true>
      <#else>
        <#return false>
      </#if>
    </#function>

    <#function getEmailAddress>
       <#if (validationErrors)?? && (validationErrors.email)?? >
        <#return validationErrors.email>
      <#elseif (formData)?? && (formData.email)?? >
        <#return formData.email>
      <#else>
        <#return ''>
      </#if>
    </#function>

    <#assign acknowledgementsCheckedAttribute=shouldCheckBoxBeChecked()?then('checked','') />
    <#assign emailAddress=getEmailAddress() />
    <#assign acknowledgementsErrorClassname=((validationErrors.acknowledgements)??)?then(properties.kcFormGroupHasErrorClass,'') />
    <#assign emailErrorClassname=((validationErrors.email)??)?then(properties.kcFormGroupHasErrorClass,'') />
    
		<div id="kc-terms-text">
      <p>${msg("profileTermsText")?no_esc}</p>
      <#if msg("collectedUserData") != ''>
        <#list msg("collectedUserData")?split(", ")>
            <div class="checked-list-title">${msg("userDataListTitle")}</div>
            <ul class="checked-list">
            <#items as dataItem>
              <li>${dataItem}</li>
            </#items>
            </ul>
        </#list>
      </#if>
      <#if msg("securitySideNote") != ''>
        <span class="hs-side-note">${msg("securitySideNote")}</span>
      </#if>
		</div>
		<form class="form-actions" id="kc-save-profile-confirm-form" action="${url.loginAction}" method="post">
      <div id="hs-email-form-group" class="${properties.kcFormGroupClass!} ${emailErrorClassname}">
        <div class="hds-text-input" id="hs-email-form-group" class="${properties.kcFormGroupClass!}">
            <label class="hds-text-input__label" for="hs-email">${msg("emailLabel")}</label>
            <input class="hds-text-input__input" type="email" name="email" id="hs-email" placeholder="${msg("emailPlaceholder")}" value="${emailAddress}"/>
            <span class="hs-error-message" role="alert">${msg("emailError")}</span>
        </div>
      </div>
      <div id="hs-acknowledgements-form-group" class="${properties.kcFormGroupClass!} ${acknowledgementsErrorClassname}">
        <div class="hds-checkbox">
            <input class="hds-checkbox__input" type="checkbox" name="acknowledgements" id="hs-acknowledgements" ${acknowledgementsCheckedAttribute}/>
            <label class="hds-checkbox__label" for="hs-acknowledgements">${msg("doAcknowledgeResources", kcSanitize(msg("doAcknowledgeResourcesPrivacyPolicyLink")), kcSanitize(msg("doAcknowledgeResourcesyDataProtectionLink")), 'target="_blank" rel="noopener noreferrer"')?no_esc}</label>
        </div>
        <span class="hs-error-message" role="alert">${msg("acknowledgementsError")}</span>
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
