<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
    <#if section = "header">
      ${msg("givenEmailIsInUseTitle")}
    <#elseif section = "form">
        <form id="kc-reclaim-email-form" action="${url.loginAction}" method="post">
            <div class="${properties.kcFormGroupClass!}">
            <#if canReclaim >
              <p>${kcSanitize(msg("givenEmailIsInUseText",(email!'')))?no_esc}</p>
            <#else>
              <p>${kcSanitize(msg("givenEmailIsInUseAndVerifiedText",(email!'')))?no_esc}</p>
            </#if>
            </div>
            <div class="${properties.kcFormGroupClass!} wide-buttons">
                <button type="submit" class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}" name="submitAction" id="updateProfile" value="updateProfile">${msg("giveAnotherEmail")}</button>
                <#if canReclaim >
                <button type="submit" class="${properties.kcButtonClass!} ${properties.kcButtonDefaultClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}" name="submitAction" id="reclaimEmail" value="reclaimEmail">${msg("reclaimEmail")}</button>
                </#if>
            </div>
        </form>
    </#if>
</@layout.registrationLayout>
