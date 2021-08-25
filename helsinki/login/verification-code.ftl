<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
    <#if section = "header">
        Verify your email address
    <#elseif section = "form">
        <p>You need to verify your email address.  We sent an email that contains a verification code.  Please enter this code into the input below.
	<form class="form-actions" id="kc-verification-code-dialog-form" action="${url.loginAction}" method="post">
      <div id="hs-verification-code-form-group">
        <div class="hds-text-input" id="hs-verification-code-form-group" class="${properties.kcFormGroupClass!}">
            <label class="hds-text-input__label" for="hs-verification-code">Verification Code</label>
            <input class="hds-text-input__input" type="text" name="verification-code" id="hs-verification-code" placeholder="1234" value=""/>
        </div>
      </div>
      <div class="wide-buttons">
			  <button class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonLargeClass!}" id="kc-accept" type="submit" value="accept">${msg("profileAcceptButtonText")}</button>
			  <button class="${properties.kcButtonClass!} ${properties.kcButtonDefaultClass!} ${properties.kcButtonLargeClass!}" id="kc-decline" type="submit" value="decline">${msg("profileDeclineButtonText")}</button>
        <input type="hidden" name="response" id="kc-response" value="" />
      </div>
    </form>
   </#if>       
</@layout.registrationLayout>
