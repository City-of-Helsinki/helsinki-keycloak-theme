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
    <#assign hasAcknowledgementsError=((validationErrors.acknowledgements)??)?then(true,false) />
    <#assign hasEmailValidationError=((validationErrors.email)??)?then(true,false) />
    
    <#assign acknowledgementsErrorClassname=hasAcknowledgementsError?then(properties.kcFormGroupHasErrorClass,'') />
    <#assign acknowledgementsInputAriaInvalid=hasAcknowledgementsError?then('true','false') />
    <#assign acknowledgementsErrorMessageRole=hasAcknowledgementsError?then('alert','') />
    
    <#assign emailErrorClassname=hasEmailValidationError?then(properties.kcFormGroupHasErrorClass,'') />
    <#assign emailInputAriaInvalid=hasEmailValidationError?then('true','false') />
    <#assign emailErrorMessageRole=hasEmailValidationError?then('alert','') />
		
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
        <span class="hs-side-note">${msg("securitySideNote")?no_esc}</span>
      </#if>
      <p class="hs-required-field-note">${msg("requiredFieldIndication")}</p>
		</div>
		<form class="form-actions" id="kc-save-profile-confirm-form" action="${url.loginAction}" method="post">
      <div id="hs-email-form-group" class="${properties.kcFormGroupClass!} ${emailErrorClassname}">
        <div class="hds-text-input">
            <label class="hds-text-input__label" for="hs-email">${msg("emailLabel")}${properties.kcAriaHiddenRequiredFieldMarker?no_esc}</label>
            <input class="hds-text-input__input" type="email" name="email" id="hs-email" placeholder="${msg("emailPlaceholder")}" value="${emailAddress}" aria-invalid="${emailInputAriaInvalid}" aria-required="true"/>
            <span class="hs-error-message hs-email-error-message" role="${emailErrorMessageRole}">${msg("emailError")}</span>
        </div>
      </div>
            <div class="${properties.kcFormGroupClass!}">
                <div class="${properties.kcLabelWrapperClass!}">
                    <label for="firstName" class="${properties.kcLabelClass!}">${msg("firstName")}</label>
                </div>
                <div class="${properties.kcInputWrapperClass!}">
                    <input type="text" id="firstName" name="firstName" value="${(user.attributes.firstName!'')}" class="${properties.kcInputClass!}" aria-invalid="<#if messagesPerField.existsError('firstName')>true</#if>" />
                    <#if messagesPerField.existsError('firstName')> 
                      <span id="input-error-firstname" class="${properties.kcInputErrorMessageClass!}" aria-live="polite"> ${kcSanitize(messagesPerField.get('firstName'))?no_esc} </span>
                    </#if>
                </div>
            </div>

            <div class="${properties.kcFormGroupClass!}">
                <div class="${properties.kcLabelWrapperClass!}">
                    <label for="lastName" class="${properties.kcLabelClass!}">${msg("lastName")}</label>
                </div>
                <div class="${properties.kcInputWrapperClass!}">
                    <input type="text" id="lastName" name="lastName" value="${(user.attributes.lastName!'')}" class="${properties.kcInputClass!}" aria-invalid="<#if messagesPerField.existsError('lastName')>true</#if>" />
                    <#if messagesPerField.existsError('lastName')>
                        <span id="input-error-lastname" class="${properties.kcInputErrorMessageClass!}" aria-live="polite"> ${kcSanitize(messagesPerField.get('lastName'))?no_esc} </span>
                    </#if>
                </div>
            </div>

      <div id="hs-acknowledgements-form-group" class="${properties.kcFormGroupClass!} ${acknowledgementsErrorClassname}">
        <div class="hds-checkbox">
            <input class="hds-checkbox__input" type="checkbox" name="acknowledgements" id="hs-acknowledgements" ${acknowledgementsCheckedAttribute} aria-invalid="${acknowledgementsInputAriaInvalid}" aria-required="true"/>
            <label class="hds-checkbox__label" for="hs-acknowledgements">${msg("doAcknowledgeResources", kcSanitize(msg("doAcknowledgeResourcesPrivacyPolicyLink")), kcSanitize(msg("doAcknowledgeResourcesyDataProtectionLink")), 'target="_blank" rel="noopener noreferrer"')?no_esc}${properties.kcAriaHiddenRequiredFieldMarker?no_esc}</label>
        </div>
        <span class="hs-error-message hs-acknowledgements-error-message" role="${acknowledgementsErrorMessageRole}">${msg("acknowledgementsError")}</span>
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
