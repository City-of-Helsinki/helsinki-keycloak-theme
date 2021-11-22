<#macro registrationLayout bodyClass="" displayInfo=false displayMessage=true displayRequiredFields=false displayWide=false showAnotherWayIfPresent=true showAlerts=true showWarnings=true showFeedbackLink=false>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" class="${properties.kcHtmlClass!}" lang="${(locale.currentLanguageTag)!realm.getDefaultLocale()}">

<head>
    <meta charset="utf-8" />
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="robots" content="noindex, nofollow" />

    <#if properties.meta?has_content>
        <#list properties.meta?split(' ') as meta>
            <meta name="${meta?split('==')[0]}" content="${meta?split('==')[1]}"/>
        </#list>
    </#if>
    <title>${msg("loginTitle",(realm.displayName!''))}</title>
    <link rel="icon" href="${url.resourcesPath}/img/favicon.ico" />
    <#if properties.styles?has_content>
        <#list properties.styles?split(' ') as style>
            <link href="${url.resourcesPath}/${style}" rel="stylesheet" />
        </#list>
    </#if>
    <#if properties.scripts?has_content>
        <#list properties.scripts?split(' ') as script>
            <script src="${url.resourcesPath}/${script}" type="text/javascript"></script>
        </#list>
    </#if>
    <#if scripts??>
        <#list scripts as script>
            <script src="${script}" type="text/javascript"></script>
        </#list>
    </#if>
</head>

<body class="${properties.kcBodyClass!}">
  <div class="${properties.kcLoginClass!}">
    <#if properties.showHeader == "true">
      <div id="kc-header" class="${properties.kcHeaderClass!}">
        <div id="kc-header-wrapper" class="${properties.kcHeaderWrapperClass!}">${kcSanitize(msg("loginTitleHtml",(realm.displayNameHtml!'')))?no_esc}</div>
      </div>
    </#if>
    <div class="${properties.kcFormCardClass!} <#if displayWide>${properties.kcFormCardAccountClass!}</#if>">
      <header class="${properties.kcFormHeaderClass!}">
        <#if realm.internationalizationEnabled && locale.supported?size gt 1>
            <div id="kc-locale-links">
                <div id="kc-locale-links-wrapper" class="${properties.kcLocaleWrapperClass!}">
                  <#list locale.supported as l>
                      <#if l.label != locale.current>
                        <a tabindex="0" lang="${l.languageTag}" aria-label="${msg("locale_${l.languageTag}.languageChangeAriaLabel")}" href="${l.url}">${msg("locale_${l.languageTag}.languageLinkTitle")}</a>
                      </#if>
                  </#list>
                </div>
            </div>
        </#if>
        <div class="logo-with-profile-text">
          <img class="${properties.hsLogo!}" src="${url.resourcesPath}/img/${msg("helsinkiLogo")}.svg" alt="Helsinki logo"/><span>${msg("profile")}</span>
        </div>
        <h1 id="kc-page-title"><#nested "header"></h1>
      </header>
      <div id="kc-content" role="main">
        <div id="kc-content-wrapper">

          <#-- App-initiated actions should not see warning messages about the need to complete the action -->
          <#-- during login.                                                                               -->
          <#if showAlerts && displayMessage && message?has_content && (message.type != 'warning' || !isAppInitiatedAction??)>
            <#-- HS: Some views have warning messages which are styled as regular paragraphs in this theme. -->
            <#-- When you downgrade some of the warnings messages into regular paragraphs, you end up with repeating content. -->
            <#-- This flag allows us to toggle off those warning messages on a template-to-template basis. -->
            <#if message.type = 'warning' && !showWarnings>
            <#elseif message.type = 'warning' && showWarnings>
                <p class="${properties.hsPClass}">${kcSanitize(message.summary)?no_esc}</p>
            <#else>
              <div class="${properties.hsAlertClass!}<#if message.type = 'success'> ${properties.hsAlertSuccessClass!}</#if><#if message.type = 'warning'> ${properties.hsAlertWarningClass!}</#if><#if message.type = 'error'> ${properties.hsAlertErrorClass!}</#if><#if message.type = 'info'> ${properties.hsAlertInfoClass!}</#if>">
                <div class="${properties.hsAlertLabelClass!}">
                    <#if message.type = 'success'><span class="${properties.kcFeedbackSuccessIcon!}"></span></#if>
                    <#if message.type = 'warning'><span class="${properties.kcFeedbackWarningIcon!}"></span></#if>
                    <#if message.type = 'error'><span class="${properties.kcFeedbackErrorIcon!}"></span></#if>
                    <#if message.type = 'info'><span class="${properties.kcFeedbackInfoIcon!}"></span></#if>
                    ${kcSanitize(message.summary)?no_esc}
                </div>
              </div>
            </#if>
          </#if>

          <#nested "form">

          <#if auth?has_content && auth.showTryAnotherWayLink() && showAnotherWayIfPresent>
          <form id="kc-select-try-another-way-form" action="${url.loginAction}" method="post" <#if displayWide>class="${properties.kcContentWrapperClass!}"</#if>>
              <div <#if displayWide>class="${properties.kcFormSocialAccountContentClass!} ${properties.kcFormSocialAccountClass!}"</#if>>
                  <div class="${properties.kcFormGroupClass!}">
                    <input type="hidden" name="tryAnotherWay" value="on" />
                    <a href="#" id="try-another-way" onclick="document.forms['kc-select-try-another-way-form'].submit();return false;">${msg("doTryAnotherWay")}</a>
                  </div>
              </div>
          </form>
          </#if>

          <#if displayInfo>
              <div id="kc-info" class="${properties.kcSignUpClass!}">
                  <div id="kc-info-wrapper" class="${properties.kcInfoAreaWrapperClass!}">
                      <#nested "info">
                  </div>
              </div>
          </#if>
        </div>
      </div>

      <#if showFeedbackLink>
        <div class="hs-footer">
            <a href="${msg('doGiveFeedbackLink')}" target="_blank" rel="noopener noreferrer">${msg("doGiveFeedback")}</a>
        </div>
      </#if>
    </div>
  </div>
</body>
</html>
</#macro>
