<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
    <#if section = "header">
        FIXME: header
    <#elseif section = "form">
        <form id="kc-service-connection-confirm-form" action="${url.loginAction}" method="post">
            <div>
                <button id="kc-accept" type="submit" name="response" value="accept">${msg("profileAcceptButtonText")}</button>
                <button id="kc-decline" type="submit" name="response" value="decline">${msg("profileDeclineButtonText")}</button>
            </div>
        </form>
    </#if>
</@layout.registrationLayout>
