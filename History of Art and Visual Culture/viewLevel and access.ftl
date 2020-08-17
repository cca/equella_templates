<#assign local = xml.getAllSubtrees('local')>
<#assign mods = xml.getAllSubtrees('mods')>

<#list local as local>
    <#assign viewLevel = local.get('viewLevel')>
    <dd class="rights">
    <#if viewLevel != "">
        This item is ${viewLevel}.<br />
    </#if>
</#list>

<#list mods as mods>
    <#assign accessCondition = mods.get('accessCondition')>
    <#if accessCondition != "">
        ${accessCondition}.</br></dd>
    </#if>
</#list>
</dl>
