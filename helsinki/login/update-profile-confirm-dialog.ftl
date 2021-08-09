<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
    <#if section = "header">
      ${msg("updateProfileTitle")}
    <#elseif section = "form">
		<div id="kc-terms-text">
      <p>${msg("updateProfileText")?no_esc}</p>
		</div>
		<form class="form-actions" id="kc-update-profile-confirm-form" action="${url.loginAction}" method="post">
      <div class="wide-buttons">
			  <button class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonLargeClass!}" id="kc-accept" type="button" value="accept">${msg("updateProfileSubmitLabel")}</button>
        <input type="hidden" name="response" id="kc-response" value="" />
      </div>
    </form>
		<div class="clearfix"></div>
    </#if>
</@layout.registrationLayout>
