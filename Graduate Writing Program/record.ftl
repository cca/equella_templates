<#assign itemUuid = xml.get('item/@id')>
<#assign itemversion = xml.get('item/@version')>
<#assign mods = xml.getAllSubtrees('mods')>
<#assign title = xml.getAllSubtrees('mods/titleInfo')>
<#assign itemAttachments = xml.getAllSubtrees('item/attachments/attachment')>
<#assign name = xml.getAllSubtrees('mods/name')>
<#assign subNameWrapper = xml.getAllSubtrees('mods/name/subNameWrapper')>
<#assign physdesc = xml.getAllSubtrees('mods/physicalDescription')>
<#assign noteWrapper = xml.getAllSubtrees('mods/noteWrapper')>
<#assign courseInfo = xml.getAllSubtrees('local/courseInfo')>
<#assign courseWork = xml.getAllSubtrees('local/courseWorkWrapper')>
<#assign local = xml.getAllSubtrees('local')>

<dl>
<#list title as mods>
    <#assign title = mods.get('title')>
    <#assign subTitle = mods.get('subTitle')>
    <h2 id="title">${title}
    </h2>
</#list>

<div id="images">
<#list itemAttachments as itemAttachment>
    <#assign thumb = itemAttachment.get('thumbnail')>
    <#assign full = itemAttachment.get('file')>
    <a href="/file/${itemUuid}/${itemversion}/${full}">
    <img src="/file/${itemUuid}/${itemversion}/${thumb}"/></a>
</#list>
</div>

<dt>Creator(s)</dt>
<#list name as mods>
    <#assign name = mods.get('namePart')>
    <dd>${name}
    <span id="namestuff">
        <#list mods.getAllSubtrees('subNameWrapper') as subName>
            <#assign major = subName.get('major')>
            <#-- <dd>${major} -->
            <#assign majorUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%2F%3E%3Cmods%3E%3Cname%3E%3Cmajor%3E${major}%3C%2Fmajor%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=Pb0cd301e-6adf-48c5-59aa-9a7a2e7f9834&q=&sort=rank&dr=AFTER" />
            <a href="${majorUrl}">${major}</a>
        </#list>
    </span>
    </dd>
</#list>

<#list courseInfo as mods>
    <#assign semester = mods.get('semester')>
    <#assign course = mods.get('course')>
    <#assign faculty = mods.get('faculty')>
    <#assign section = mods.get('section')>
    <#-- <dd>${course} -->
    <#-- <dd>${semester} -->
    <#-- <dd>${faculty} -->
    <#-- <dd>${section} -->
    <#assign courseUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Ccourse%3E${course}%3C%2Fcourse%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P41b33eb0-0aa4-4c89-a895-381c43e5d27a&q=&sort=datemodified&dr=AFTER" />
    <#assign semesterUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Csemester%3E${semester}%3C%2Fsemester%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P41b33eb0-0aa4-4c89-a895-381c43e5d27a&q=&sort=datemodified&dr=AFTER" />
    <#assign facultyUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Cfaculty%3E${faculty}%3C%2Ffaculty%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P41b33eb0-0aa4-4c89-a895-381c43e5d27a&q=&sort=datemodified&dr=AFTER" />
    <#assign sectionUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Csection%3E${section}%3C%2Fsection%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P41b33eb0-0aa4-4c89-a895-381c43e5d27a&q=&sort=datemodified&dr=AFTER" />
    <#if (semester=="")><#else>
    <dt>Course Info</dt>
    <span id="namestuff"><a href="${semesterUrl}">${semester}</a>
        <#if (course=="")>
            <#else> — <a href="${courseUrl}">${course}</a>
        </#if>
        <#if faculty=="">
            <#else> — <a href="${facultyUrl}">${faculty}</a>
        </#if>
        <#if section=="">
            <#else> — <a href="${sectionUrl}">${section}</a>
        </#if>
    </span>
    </dd>
    </#if>
</#list>


<#list physdesc as physdesc>
    <#assign formBroad = physdesc.get('formBroad')>
    <#assign formSpecific = physdesc.get('formSpecific')>
    <#-- <dd>${formBroad} -->
    <#-- <dd>${formSpecific} -->
    <#assign formBroadUrl = "/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3CphysicalDescription%3E%3CformBroad%3E${formBroad}%3C%2FformBroad%3E%3C%2FphysicalDescription%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=P41b33eb0-0aa4-4c89-a895-381c43e5d27a&q=&sort=datemodified&dr=AFTER" />
    <#assign formSpecificUrl = "/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3CphysicalDescription%3E%3CformSpecific%3E${formSpecific}%3C%2FformSpecific%3E%3C%2FphysicalDescription%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=P41b33eb0-0aa4-4c89-a895-381c43e5d27a&q=&sort=datemodified&dr=AFTER" />
    <#if (formBroad=="")><#else>
    <dt>Project Description</dt></#if>
    <dd>Work type: <a href="${formBroadUrl}">${formBroad}</a> - <a href="${formSpecificUrl}">${formSpecific}</a> -
</#list>

<#list courseWork as courseWork>
    <#assign courseWorkType = courseWork.get('courseWorkType')>
    <#-- <dd>${courseWorkType} -->
    <#assign courseWorkTypeUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3E${courseWorkType}%3C%2FcourseWorkType%3E%3C%2FcourseWorkWrapper%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P41b33eb0-0aa4-4c89-a895-381c43e5d27a&q=&sort=datemodified&dr=AFTER" />
    <a href="${courseWorkTypeUrl}">${courseWorkType}</a>
</#list>
</dd>

<#list mods as mods>
    <#assign abstract = mods.get('abstract')>
    <#if (abstract=="")><#else>
    <dd>Script/Dialogue: ${abstract}</dd></#if>
</#list>

<#list noteWrapper as note>
    <#assign note = note.get('note')>
    <#if (note=="")><#else>
    <dd>Additional Notes: ${note}</dd></#if>
</#list>
