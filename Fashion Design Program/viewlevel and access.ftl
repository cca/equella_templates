<#assign modslevel = xml.getAllSubtrees('mods')>
<#assign local = xml.getAllSubtrees('local')>
<dt class="hide">Rights</dt>
<dd class="rights">
<#list local as local>
    <#assign viewLevel = local.get('viewLevel')>
    <#if viewLevel==""><#else>
    This item is ${viewLevel}.</#if><br />
    </#list>

<#list modslevel as mods>
    <#assign accessCondition = mods.get('accessCondition')>

        For rights relating to this resource, contact the <a href="mailto:fashiondesign@cca.edu?Subject=Inquiry%20about%20Vault%20images" target="_top">${accessCondition}</a>.</br>

</#list>
</dd>
</dl>
