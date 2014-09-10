<#assign modslevel = xml.getAllSubtrees('mods')>
<#assign local = xml.getAllSubtrees('local')>
<div style="clear:both;"></div>
<#list local as local>
    <#assign viewLevel = local.get('viewLevel')>
    <#-- <dd>${viewLevel} -->
    <#assign viewLevelUrl = "" />
    <#if viewLevel==""><#else>
    <dd class="rights">This item is ${viewLevel}.</#if>
    </#list>

<#list modslevel as mods>
    <#assign accessCondition = mods.get('accessCondition')>
    <#if accessCondition==""><#else>
    <br>${accessCondition}</br></dd></#if>

</#list>
<div style="clear:both;"></div>
