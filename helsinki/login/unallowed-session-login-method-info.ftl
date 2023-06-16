<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=false; section>
    <#if section = "header">
        ${kcSanitize(msg("unallowedSessionLoginMethodTitle"))?no_esc}
    <#elseif section = "form">
        <div id="kc-info-message">
            <p class="instruction">${kcSanitize(msg("unallowedSessionLoginMethodText"))?no_esc}</p>
            <#if backToApplicationUrl?has_content>
                <p><a id="backToApplication" href="${backToApplicationUrl}">${kcSanitize(msg("backToApplication"))?no_esc}</a></p>
            </#if>
        </div>
    </#if>
</@layout.registrationLayout>
