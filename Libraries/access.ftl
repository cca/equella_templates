<#assign modslevel = xml.getAllSubtrees('mods')>
<#list modslevel as mods>
    <#assign accessCondition = mods.get('accessCondition')>
    <#if accessCondition != "">
        <dt class="hide">Rights</dt>
        <dd class="rights">${accessCondition}</dd>
    </#if>
</#list>
