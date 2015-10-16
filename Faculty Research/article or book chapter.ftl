<h3>Details</h3>

<#assign authors = xml.getAllSubtrees('mods/name')>
<dd><b>Authors</b>:
    <#list authors as author>
        <#assign role = author.get('role/roleTerm')>
        ${author.get('namePart')}<#if role != "author">&nbsp;(${role})</#if><#if author_has_next>, </#if>
    </#list>
</dd>

<dd><b>Type</b>: ${xml.get('mods/genreWrapper/genre')}</dd>

<#assign publication = xml.get('mods/relatedItem/title')>
<#assign date = xml.get('mods/relatedItem/part/date')>
<#assign details = xml.getAllSubtrees('mods/relatedItem/part/detail')>
<#assign startPg = xml.get('mods/relatedItem/part/extent/start')>
<#assign endPg = xml.get('mods/relatedItem/part/extent/end')>
<dd>
    <#-- newlines in the markup turn into white space, thus why
    this monstrosity is all on one lines -->
    <b>Publication</b>: <#if publication != ''><cite>${publication}</cite></#if><#if date != ''> (${date})</#if><#if details?size != 0>,<#list details as detail>&nbsp;${detail.get('caption')}&nbsp;${detail.get('number')}</#list></#if><#if startPg != ''>, p.&nbsp;${startPg}<#if endPg != ''>-${endPg}</#if></#if>
</dd>

<#assign num = xml.get('mods/relatedItem/identifier')>
<#assign numType = xml.get('mods/relatedItem/identifier/@type')>
<#if num != ''>
    <dd>
        <b>${numType?upper_case}</b>:&nbsp;${num}
    </dd>
</#if>
