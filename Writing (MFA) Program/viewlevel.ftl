<#assign viewLevel = xml.get('local/viewLevel')>
<#if viewLevel != "">
    <dd class="rights">This item is <strong>${viewLevel}.</strong></dd>
</#if>

<#assign accessCondition = xml.get('mods/accessCondition')>
<#if accessCondition != "">
    <dd>${accessCondition}</dd>
</#if>

<hr>
