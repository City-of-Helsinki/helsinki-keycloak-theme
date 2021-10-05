<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
    <#if section = "header">
        The given email address is already registered 🤬
    <#elseif section = "form">
        <form id="kc-register-form" action="${url.loginAction}" method="post">
            <p>
            The email address <b>${(email!'')}</b> has been already register by another user. You can press "reclaim email" to regain control of it. 
            </p>
            <div class="${properties.kcFormGroupClass!}">
                <button type="submit" class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}" name="submitAction" id="updateProfile" value="updateProfile">${msg("confirmLinkIdpReviewProfile")}</button>
                <#if canReclaim >
                <button type="submit" class="${properties.kcButtonClass!} ${properties.kcButtonDefaultClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}" name="submitAction" id="reclaimEmail" value="reclaimEmail">Reclaim email</button>
                </#if>
            </div>
        </form>
    </#if>
</@layout.registrationLayout>
