<#assign modslevel = xml.getAllSubtrees('mods')>
<#assign local = xml.getAllSubtrees('local')>
<dt class="hide">Rights</dt>
<dd class="rights">
<#list local as local>
    <#assign viewLevel = local.get('viewLevel')>
    <#if viewLevel==""><#else>
    This item is ${viewLevel}.</#if>
    </#list>

<#list modslevel as mods>
    <#assign accessCondition = mods.get('accessCondition')>
    <#if viewLevel=="">
        ${accessCondition}.</br>
    <#else>
        <br>${accessCondition}.</br>
    </#if>

</#list>
</dd>
