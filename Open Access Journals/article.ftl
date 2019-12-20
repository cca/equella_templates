<#assign mods = xml.getSubtree('mods')>

<#assign title = mods.get('titleInfo/title')>
<#if title != ''>
    <h2>${title}</h2>
</#if>

<#assign url = mods.get('location/url')>
<#if url != ''>
    <dd><a href="${url}">View full text online.</a></dd>
</#if>

<#-- citation template copied from Faculty Research collection -->
<#assign author = mods.get('name/namePart')>
<#assign publication = xml.get('mods/relatedItem/titleInfo/title')>
<#assign date = xml.get('mods/relatedItem/part/date')>
<#assign details = xml.getAllSubtrees('mods/relatedItem/part/detail')>
<#assign startPg = xml.get('mods/relatedItem/extent/start')>
<dd>
    <#-- newlines in the markup turn into white space, thus why
    this monstrosity is all on one lines -->
    <b>Citation</b>: <#if author != ''>${author}.</#if> "${title}". <#if publication != ''><cite>${publication}</cite></#if><#if date != ''> (${date})</#if><#if details?size != 0>,<#list details as detail>&nbsp;${detail.get('caption')}&nbsp;${detail.get('number')}</#list></#if><#if startPg != ''>, p.&nbsp;${startPg}</#if>.
</dd>
