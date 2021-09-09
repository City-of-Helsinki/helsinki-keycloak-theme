<#ftl output_format="plainText">
<#assign lines = msg("emailVerificationBodyCode",code)?split("\\n") />
<#list lines as line>
${line}
</#list>

${msg("emailVerificationCodeFooter")}