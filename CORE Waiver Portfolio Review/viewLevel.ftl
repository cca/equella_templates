<#assign modslevel = xml.getAllSubtrees('mods')>
<#assign local = xml.getAllSubtrees('local')>

<#list local as local>
    <#assign viewLevel = local.get('viewLevel')>
    <#if viewLevel != "">
        <dd class="rights" style="border-top:0; border-bottom:0;">This item is <strong>${viewLevel}.</strong>
    </#if>
</#list>

<#list modslevel as mods>
    <#assign accessCondition = mods.get('accessCondition')>
    <#if accessCondition != "">
        <br>${accessCondition}</br></dd>
    </#if>
</#list>

<dd><hr></dd>
