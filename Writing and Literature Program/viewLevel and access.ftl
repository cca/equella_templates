<#assign local = xml.getAllSubtrees('local')>
<#assign mods = xml.getAllSubtrees('mods')>

<#list local as local>
    <#assign viewLevel = local.get('viewLevel')>
    <#-- <dd>${viewLevel} -->
    <#assign viewLevelUrl = "" />
    <dd class="rights">
    <#if viewLevel==""><#else>
    This item is ${viewLevel}.<br /></#if>
    </#list>

<#list mods as mods>
    <#assign accessCondition = mods.get('accessCondition')>
    <#if accessCondition==""><#else>
    ${accessCondition}.</br></dd></#if>
</#list>
</dl>
