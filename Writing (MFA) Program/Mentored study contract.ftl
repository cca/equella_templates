<#assign itemUuid = xml.get('item/@id')>
<#assign itemversion = xml.get('item/@version')>
<#assign itemAttachments = xml.getAllSubtrees('item/attachments/attachment')>
<#assign name = xml.getAllSubtrees('mods/name')>
<#assign courseInfo = xml.getAllSubtrees('local/courseInfo')>

<#if xml.get('local/courseWorkWrapper/courseWorkType') == 'Mentored study contract'>

<dl>
    <#assign title = xml.get('mods/titleInfo/title')>
    <h2 id="title">${title}</h2>

<div id="images">
    <#list itemAttachments as itemAttachment>
        <#assign uuid = itemAttachment.get('uuid')>
        <#assign full = itemAttachment.get('file')>
        <a href="/file/${itemUuid}/${itemversion}/${full}">
        <img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
    </#list>
</div>

<dt>Student &amp; Mentor</dt>
<dd><b>Student</b>:
<#list name as name>
    <#assign namePart = name.get('namePart')>
    ${namePart}
        <#assign major = name.get('subNameWrapper/major')>
        <#if major != "">
            <#assign majorUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%2F%3E%3Cmods%3E%3Cname%3E%3Cmajor%3E${major}%3C%2Fmajor%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=Pb0cd301e-6adf-48c5-59aa-9a7a2e7f9834&q=&sort=rank&dr=AFTER" />
            &nbsp;-&nbsp;<a href="${majorUrl}">${major}</a>
        </#if>
    </dd>
</#list>
<dd><b>Mentor</b>: ${xml.get('local/courseInfo/faculty')}</dd>

<dt>Details</dt>
<dd><b>Created</b>: ${xml.get('mods/dateCreatedWrapper/dateCreated')}</dd>
<dd><b>Meeting Times</b>: ${xml.get('mods/origininfo/dateOtherWrapper/dateOther')}</dd>

<#assign project = xml.get('local/assignmentWrapper/description')>
<#if project != ''>
<dd><b>Project Assignments</b><br> ${project}</dd>
</#if>

<#assign reading = xml.get('local/assignmentWrapper/references')>
<#if reading != ''>
<dd><b>Reading Assignments</b><br> ${reading}</dd>
</#if>

<#assign focus = xml.get('mods/abstract')>
<#if focus != ''>
<dd><b>Focus</b><br> ${focus}</dd>
</#if>

</#if>
