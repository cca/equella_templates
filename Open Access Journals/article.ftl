<#assign mods = xml.getSubtree('mods')>

<#assign title = mods.get('titleInfo/title')>
<#if title != ''>
    <h2>${title}</h2>
</#if>

<dl>
<#assign url = mods.get('location/url')>
<#if url != ''>
    <dt>Location online:</dt><dd><a href="${url}">${url}</a></dd>
</#if>

<#-- citation template copied from Faculty Research collection -->
<#assign author = mods.get('name/namePart')>
<#assign publication = xml.get('mods/relatedItem/titleInfo/title')>
<#assign issn = xml.get('mods/relatedItem/identifier')>
<#assign date = xml.get('mods/relatedItem/part/date')>
<#assign details = xml.getAllSubtrees('mods/relatedItem/part/detail')>
<#assign startPg = xml.get('mods/relatedItem/part/extent/start')>
<#if author != ''>
    <dt>Author(s):</dt><dd>${author}</dd>
</#if>
<#if publication != ''>
    <dt>Journal:</dt><dd>${publication} <#if issn != ''>${issn}</#if></dd>
</#if>
<#if date != ''>
    <dt>Date:</dt><dd>${date}</dd>
</#if>
<#if details?size != 0>
    <dt>Issue Details:</dt><dd><#list details as detail>${detail.get('caption')}&nbsp;${detail.get('number')}</#list>. <#if startPg != ''>Start page: ${startPg}.</#if></dd>
</#if>

<#-- newlines in markup turn into white space, thus why this is all on one line -->
<dt>Citation</dt>
<dd>
    <#if author != ''>${author}.</#if> "${title}". <#if publication != ''><cite>${publication}</cite></#if><#if date != ''> (${date})</#if><#if details?size != 0>,<#list details as detail>&nbsp;${detail.get('caption')}&nbsp;${detail.get('number')}</#list></#if><#if startPg != ''>, p.&nbsp;${startPg}</#if>.
</dd>

</dl>
