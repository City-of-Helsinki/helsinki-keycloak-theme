<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
  <#if section = "header">
      ${msg("verificationCodeFormTitle")}
  <#elseif section = "form">

    <#assign hasValidationErrors=((validationErrors.code)??)?then(true,false) />
    <#assign verificationCodeErrorClassname=hasValidationErrors?then(properties.kcFormGroupHasErrorClass,'') />
    <#assign ariaInvalid=hasValidationErrors?then('true','false') />
    <p>${msg("verificationCodeWasSentTo")} <b>${(email!'')}</b></p>
    <div>
      <p>${msg("verificationCodeFormText")}</p>
    </div>
    <form class="form-actions" id="kc-email-verification-code-form" action="${url.loginAction}" method="post">
      <div class="${properties.kcFormGroupClass!} ${verificationCodeErrorClassname}">
        <div class="hds-text-input">
          <label class="hds-text-input__label" for="hs-verification-code">${msg("verificationCodeFormLabel")}</label>
          <input class="hds-text-input__input" type="text" name="code" id="hs-verification-code" placeholder="123456" value="" aria-invalid="${ariaInvalid}"/>
          <span class="hs-error-message" role="alert">${msg("verificationCodeFormError")}</span>
        </div>
      </div>
      <div class="wide-buttons">
        <button class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonLargeClass!}" id="kc-accept" type="submit" value="accept">${msg("continue")}</button>
        <button class="${properties.kcButtonClass!} ${properties.kcButtonDefaultClass!} ${properties.kcButtonLargeClass!}" id="kc-decline" type="button" value="decline">${msg("profileDeclineButtonText")}</button>
        <input type="hidden" name="response" id="kc-response" value="" />
      </div>
    </form>
  </#if>       
</@layout.registrationLayout>
