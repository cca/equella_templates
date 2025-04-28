<#assign viewLevel = xml.get('local/viewLevel')>
<#if viewLevel != "">
    <dd class="rights" style="border-top:0; border-bottom:0;">This item is <strong>${viewLevel}.</strong></dd>
</#if>

<#assign accessCondition = xml.get('mods/accessCondition')>
<#if accessCondition != "">
    <dd>${accessCondition}</dd>
</#if>

<dd><hr></dd>
