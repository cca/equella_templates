<#assign itemUuid = xml.get('item/@id')>
<#assign itemversion = xml.get('item/@version')>
<#assign itemAttachments = xml.getAllSubtrees('item/attachments/attachment')>
<#assign name = xml.getAllSubtrees('mods/name')>
<#assign titleInfo = xml.getAllSubtrees('mods/titleInfo')>
<#assign modslevel = xml.getAllSubtrees('mods')>
<#assign date = xml.getAllSubtrees('mods/origininfo/dateCreatedWrapper')>
<#assign subject = xml.getAllSubtrees('mods/subject')>
<#assign relateditem = xml.getAllSubtrees('mods/relateditem')>
<#assign location = xml.getAllSubtrees('mods/location')>
<#assign local = xml.getAllSubtrees('local')>
<#assign communications = xml.getAllSubtrees('local/communicationsWrapper')>

<dl>
<dt>Press Clip</dt>
<#list titleInfo as titleInfo>
    <#assign title = titleInfo.get('title')>
        <dd>Title: <em>${title}</em></dd>
</#list>

<#list name as name>
    <#assign namePart = name.get('namePart')>
    <#if name == "">No author<#else>
        <dd>Author: ${name}</dd>
    </#if>
</#list>

<#list date as date>
    <#assign dateCreated = date.get('dateCreated')>
    <#if dateCreated != "">
        <dd>Date: ${dateCreated}</dd>
    </#if>
</#list>

<#list relateditem as relateditem>
    <#assign title = relateditem.get('title')>
    <#if title != "">
        <dd>Publication: <em>${title}</em></dd>
    </#if>
</#list>

<#list location as location>
    <#assign url = location.get('url')>
    <#list itemAttachments as itemAttachment>
        <#assign urlUuid = itemAttachment.get('uuid')>
        <#assign file = itemAttachment.get('file')>
        <#if url == urlUuid>
            <dd>Article URL: <a href="${file}">${file}</a></dd>
        </#if>
    </#list>
</#list>
<dt>Named CCA information</dt>
<#list communications as communications>
    <#assign ccaNamed = communications.get('ccaNamed')>

    <#list communications.getAllSubtrees('depictedWrapper') as depicted>
        <#assign depictedPerson = depicted.get('depictedPerson')>
        <#assign depictedConstituents = depicted.get('depictedConstituents')>
        <#assign depictedDept = depicted.get('depictedDept')>
        <#assign depictedPersonUrl = "https://vault.cca.edu/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcommunicationsWrapper%3E%3CdepictedWrapper%3E%3CdepictedPerson%3E${depictedPerson}%3C%2FdepictedPerson%3E%3C%2FdepictedWrapper%3E%3C%2FcommunicationsWrapper%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P04c5d28c-713c-37fe-5e33-6c0ee78651f0&q=&sort=datemodified&dr=AFTER" />
        <#assign depictedConstituentsUrl = "https://vault.cca.edu/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcommunicationsWrapper%3E%3CdepictedWrapper%3E%3CdepictedConstituents%3E${depictedConstituents}%3C%2FdepictedConstituents%3E%3C%2FdepictedWrapper%3E%3C%2FcommunicationsWrapper%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P04c5d28c-713c-37fe-5e33-6c0ee78651f0&q=&sort=datemodified&dr=AFTER" />
        <#assign depictedDeptUrl = "https://vault.cca.edu/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcommunicationsWrapper%3E%3CdepictedWrapper%3E%3CdepictedDept%3E${depictedDept}%3C%2FdepictedDept%3E%3C%2FdepictedWrapper%3E%3C%2FcommunicationsWrapper%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P04c5d28c-713c-37fe-5e33-6c0ee78651f0&q=&sort=datemodified&dr=AFTER" />
        <dd><#-- depictedPerson exists & is followed by something -->
        <#if depictedPerson != "" && (depictedConstituents != "" || depictedDept != "")>
            <a href="${depictedPersonUrl}">${depictedPerson}</a> -
        <#-- depictedPerson exists but nothing follows it -->
        <#elseif depictedPerson != "">
            <a href="${depictedPersonUrl}">${depictedPerson}</a>
        </#if>
        <#-- depictedConstitutents exists & is followed by smth -->
        <#if depictedConstituents != "" && depictedDept != "">
            <em><a href="${depictedConstituentsUrl}">${depictedConstituents}</a></em> -
        <#elseif depictedConstituents != "">
            <em><a href="${depictedConstituentsUrl}">${depictedConstituents}</a></em>
        </#if>
        <#if depictedDept != "">
             <em><a href="${depictedDeptUrl}">${depictedDept}</a></em>
        </#if></dd>
    </#list>
    <dd>Was CCA named?
        <#if ccaNamed == ""><em>no</em><#else>
         <em>${ccaNamed}</em></dd>
    </#if>
</#list>

<#list subject as subject>
    <#assign obituary = subject.get('topic')>
    <#if obituary != "">
        <dd>This was an <em>${obituary}.</em></dd>
    </#if>
</#list>

<#list modslevel as mods>
    <#assign abstract = mods.get('abstract')>
    <#assign toc = mods.get('tableOfContents')>
    <#if abstract != "">
        <dd>Description: ${abstract}</dd>
    </#if>
</#list>
</dl>
