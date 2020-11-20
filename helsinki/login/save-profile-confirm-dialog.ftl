<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
    <#if section = "header">
        Your data will be stored
    <#elseif section = "form">
		<div id="kc-terms-text">
			Your personal data will be stored to Profile. 

		</div>
		<form class="form-actions" action="${url.loginAction}" method="POST">
			<input class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonLargeClass!}" name="response" id="kc-accept" type="submit" value="accept"/>
			<input class="${properties.kcButtonClass!} ${properties.kcButtonDefaultClass!} ${properties.kcButtonLargeClass!}" name="response" id="kc-decline" type="submit" value="decline"/>
		</form>
		<div class="clearfix"></div>
    </#if>
</@layout.registrationLayout>
