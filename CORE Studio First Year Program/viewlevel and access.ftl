<#assign modslevel = xml.getAllSubtrees('mods')>
<#assign local = xml.getAllSubtrees('local')>

<#list local as local>
    <#assign viewLevel = local.get('viewLevel')>
    <#if viewLevel==""><#else>
    <dd class="rights">This item is <strong>${viewLevel}.</strong></#if>
    </#list>

<#list modslevel as mods>
    <#assign accessCondition = mods.get('accessCondition')>

    <#if accessCondition==""><#else>
    <br>${accessCondition}</br></dd></#if>

</#list>
</dl>
