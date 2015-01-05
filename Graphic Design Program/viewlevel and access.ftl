<dt class="hide">Rights</dt>
<dd class="rights">
    <#assign viewLevel = xml.get('local/viewLevel')>
    <#if viewLevel != "">This item is ${viewLevel}.</#if>

    <#assign accessCondition = xml.get('mods/accessCondition')>
    <#if viewLevel == "">
        ${accessCondition}.</br>
    <#else>
        <br>${accessCondition}.</br>
    </#if>
</dd>
