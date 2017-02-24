<#assign itemUuid = xml.get('item/@id')>
<#assign itemVersion = xml.get('item/@version')>
<#assign itemAttachments = xml.getAllSubtrees('item/attachments/attachment')>

<#if xml.get('local/courseWorkWrapper/courseWorkType') == '1111 Archive'>
<dl>
    <h2 id="title">${xml.get('mods/titleInfo/title')}</h2>

<dt>Details</dt>

<#assign url = xml.get('mods/location/url')>
<#if url != ''>
    <dd><b>Issue URL</b>: <a href="${url}">${url}</a></dd>
</#if>

<#assign year = xml.get('mods/origininfo/dateCreatedWrapper/dateCreated')>
<#if year != ''>
    <dd><b>Year</b>: ${year}</dd>
</#if>

<#assign details = xml.getAllSubtrees('mods/part/detail')>
<#if details?size != 0>
    <dd>
        <#-- must be one line b/c newlines in markup turn into white space -->
        <b>Details</b>:<#list details as detail>&nbsp;${detail.get('caption')}&nbsp;${detail.get('number')}</#list>
    </dd>
</#if>

<#assign attachments = xml.list('mods/part/number')>
<#list attachments as attachment>
    <#list itemAttachments as itemAttachment>
        <#if attachment == itemAttachment.get('uuid') && itemAttachment.get('@type') == 'zip'>
            <#assign zipname = itemAttachment.get('description')>
            <dd><b>Browse files:</b>
                <#-- link to the "tilde view" starting at the root of the zip archive -->
                <a href="/items/${itemUuid}/${itemVersion}/${zipname}/~">${zipname}</a>
            </dd>
        </#if>
    </#list>
</#list>

<#assign abstract = xml.get('mods/abstract')>
<#if abstract != ''>
    <dt>Notes</dt>
    <dd><pre>${abstract}</pre></dd>
</#if>

<#assign tableOfContents = xml.get('mods/tableOfContents')>
<#if tableOfContents != ''>
    <dt>Table of Contents</dt>
    <dd><pre>${tableOfContents}</pre></dd>
</#if>

<br><br>
<dd>Published by ${xml.get('mods/originInfo/publisher')} in ${xml.get('mods/originInfo/place/placeTerm')}.</dd>

</#if>
