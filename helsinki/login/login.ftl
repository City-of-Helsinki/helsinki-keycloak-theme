<#import "template.ftl" as layout>
<#if client.attributes["helsinkitunnistus.loginmethods"]??>
    <#assign clientLoginMethods = client.attributes["helsinkitunnistus.loginmethods"]?split("##") />
    <#assign clientSupportsHelsinkiTunnus = clientLoginMethods?seq_contains("helsinki_tunnus") />
    <#assign clientSocialProviders = social.providers?filter(p -> clientLoginMethods?seq_contains(p.alias)) />
<#else>
    <#assign clientSupportsHelsinkiTunnus = true />
    <#assign clientSocialProviders = social.providers />
</#if>

<@layout.registrationLayout displayInfo=social.displayInfo displayWide=(realm.password && clientSocialProviders??) showFeedbackLink=true; section>
    <#if section = "header">
        ${msg("doLogIn")}
    <#elseif section = "form">

    <div id="kc-form" <#if realm.password && clientSocialProviders??>class="${properties.kcContentWrapperClass!}"</#if>>
      <div id="kc-form-wrapper" <#if realm.password && clientSocialProviders??>class="${properties.kcFormSocialAccountContentClass!} ${properties.kcFormSocialAccountClass!}"</#if>>
        <#if realm.password && clientSupportsHelsinkiTunnus>
            <form id="kc-form-login" onsubmit="login.disabled = true; return true;" action="${url.loginAction}" method="post">
                <div class="${properties.kcFormGroupClass!}">
                    <label for="username" class="${properties.kcLabelClass!}"><#if !realm.loginWithEmailAllowed>${msg("username")}<#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}<#else>${msg("email")}</#if></label>

                    <#if usernameEditDisabled??>
                        <input tabindex="1" id="username" class="${properties.kcInputClass!}" name="username" value="${(login.username!'')}" type="text" disabled />
                    <#else>
                        <input tabindex="1" id="username" class="${properties.kcInputClass!}" name="username" value="${(login.username!'')}"  type="text" autofocus autocomplete="off" />
                    </#if>
                </div>

                <div class="${properties.kcFormGroupClass!}">
                    <label for="password" class="${properties.kcLabelClass!}">${msg("password")}</label>
                    <input tabindex="2" id="password" class="${properties.kcInputClass!}" name="password" type="password" autocomplete="off" />
                </div>

                <#if realm.rememberMe && !usernameEditDisabled??>
                    <div class="${properties.kcFormGroupClass!} ${properties.kcFormSettingClass!}">
                        <div id="kc-form-options">
                            <div class="checkbox">
                                <label>
                                    <#if login.rememberMe??>
                                        <input tabindex="3" id="rememberMe" name="rememberMe" type="checkbox" checked> ${msg("rememberMe")}
                                    <#else>
                                        <input tabindex="3" id="rememberMe" name="rememberMe" type="checkbox"> ${msg("rememberMe")}
                                    </#if>
                                </label>
                            </div>
                        </div>
                    </div>
                </#if>

                  <div id="kc-form-buttons" class="${properties.kcFormGroupClass!}">
                      <input type="hidden" id="id-hidden-input" name="credentialId" <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if>/>
                      <input tabindex="4" class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}" name="login" id="kc-login" type="submit" value="${msg("doLogIn")}"/>
                  </div>

                  <#if realm.resetPasswordAllowed>
                      <div id="hs-reset-password" class="${properties.kcFormGroupClass!}">
                          <a tabindex="4" class="${properties.hsLinkClass!}" href="${url.loginResetCredentialsUrl}">${msg("forgotPassword")}</a>
                      </div>
                  </#if>
            </form>
        </#if>
        </div>
        <#if realm.password && clientSocialProviders??>
            <div id="kc-social-providers" class="${properties.kcFormSocialAccountContentClass!} ${properties.kcFormSocialAccountClass!}">
                <ul class="${properties.kcFormSocialAccountListClass!} <#if clientSocialProviders?size gt 3>${properties.kcFormSocialAccountListGridClass!}</#if>">
                    <#list clientSocialProviders as p>
                        <a id="social-${p.alias}" class="${properties.kcFormSocialAccountListButtonClass!} <#if clientSocialProviders?size gt 3>${properties.kcFormSocialAccountGridItem!}</#if>"
                                type="button" href="${p.loginUrl}">
                            <#if p.iconClasses?has_content>
                                <i class="${properties.kcCommonLogoIdP!} ${p.iconClasses!}" aria-hidden="true"></i>
                                <span class="${properties.kcFormSocialAccountNameClass!} kc-social-icon-text">${p.displayName!}</span>
                            <#else>
                                <span class="${properties.kcFormSocialAccountNameClass!}">${p.displayName!}</span>
                            </#if>
                        </a>
                    </#list>
                </ul>
            </div>
        </#if>
      </div>
    <#elseif section = "info" >
        <#if realm.password && realm.registrationAllowed && !registrationDisabled?? && clientSupportsHelsinkiTunnus>
            <div id="kc-registration">
                <span class="${properties.hsSubtitle!}">${msg("noAccount")}</span>
                <a tabindex="6" class="${properties.kcButtonClass!} ${properties.kcButtonDefaultClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}" href="${url.registrationUrl}">${msg("doRegister")}</a>
            </div>
        </#if>
    </#if>

</@layout.registrationLayout>
