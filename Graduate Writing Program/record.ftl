<#assign itemUuid = xml.get('item/@id')>
<#assign itemversion = xml.get('item/@version')>
<#assign itemAttachments = xml.getAllSubtrees('item/attachments/attachment')>
<#assign name = xml.getAllSubtrees('mods/name')>
<#assign courseInfo = xml.getAllSubtrees('local/courseInfo')>

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

<dt>Creator(s)</dt>
<#list name as name>
    <#assign namePart = name.get('namePart')>
    <dd>${namePart}
        <#assign major = name.get('subNameWrapper/major')>
        <#if major != "">
            <#assign majorUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%2F%3E%3Cmods%3E%3Cname%3E%3Cmajor%3E${major}%3C%2Fmajor%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=Pb0cd301e-6adf-48c5-59aa-9a7a2e7f9834&q=&sort=rank&dr=AFTER" />
            &nbsp;-&nbsp;<a href="${majorUrl}">${major}</a>
        </#if>
    </dd>
</#list>

<#list courseInfo as courseInfo>
    <#assign semester = courseInfo.get('semester')>
    <#assign course = courseInfo.get('course')>
    <#assign faculty = courseInfo.get('faculty')>
    <#assign section = courseInfo.get('section')>
    <#assign courseUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Ccourse%3E${course}%3C%2Fcourse%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P41b33eb0-0aa4-4c89-a895-381c43e5d27a&q=&sort=datemodified&dr=AFTER" />
    <#assign semesterUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Csemester%3E${semester}%3C%2Fsemester%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P41b33eb0-0aa4-4c89-a895-381c43e5d27a&q=&sort=datemodified&dr=AFTER" />
    <#assign facultyUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Cfaculty%3E${faculty}%3C%2Ffaculty%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P41b33eb0-0aa4-4c89-a895-381c43e5d27a&q=&sort=datemodified&dr=AFTER" />
    <#assign sectionUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Csection%3E${section}%3C%2Fsection%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P41b33eb0-0aa4-4c89-a895-381c43e5d27a&q=&sort=datemodified&dr=AFTER" />
    <#if (semester != "")>
    <dt>Course Info</dt>
    <dd>
        <a href="${semesterUrl}">${semester}</a>
        <#if (course != "")> — <a href="${courseUrl}">${course}</a></#if>
        <#if faculty != ""> — <a href="${facultyUrl}">${faculty}</a></#if>
        <#if section != ""> — <a href="${sectionUrl}">${section}</a></#if>
    </dd>
    </#if>
</#list>

<#assign formBroad = xml.get('mods/physicalDescription/formBroad')>
<#assign formSpecific = xml.get('mods/physicalDescription/formSpecific')>
<#assign formBroadUrl = "/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3CphysicalDescription%3E%3CformBroad%3E${formBroad}%3C%2FformBroad%3E%3C%2FphysicalDescription%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=P41b33eb0-0aa4-4c89-a895-381c43e5d27a&q=&sort=datemodified&dr=AFTER" />
<#assign formSpecificUrl = "/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3CphysicalDescription%3E%3CformSpecific%3E${formSpecific}%3C%2FformSpecific%3E%3C%2FphysicalDescription%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=P41b33eb0-0aa4-4c89-a895-381c43e5d27a&q=&sort=datemodified&dr=AFTER" />
<#if (formBroad != "")>
    <dt>Project Description</dt>
    <dd>Work type: <a href="${formBroadUrl}">${formBroad}</a> - <a href="${formSpecificUrl}">${formSpecific}</a>
</#if>

<#assign courseWorkType = xml.get('local/courseWorkWrapper/courseWorkType')>
<#assign courseWorkTypeUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3E${courseWorkType}%3C%2FcourseWorkType%3E%3C%2FcourseWorkWrapper%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P41b33eb0-0aa4-4c89-a895-381c43e5d27a&q=&sort=datemodified&dr=AFTER" />
<a href="${courseWorkTypeUrl}"> - ${courseWorkType}</a>
</dd>

<#assign abstract = xml.get('mods/abstract')>
<#if (abstract != "")>
    <dd>Script/Dialogue: ${abstract}</dd>
</#if>

<#assign note = xml.get('mods/noteWrapper/note')>
<#if (note != "")>
    <dd>Additional Notes: ${note}</dd>
</#if>
