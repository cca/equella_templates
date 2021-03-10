<#function escapeAmp str>
    <#-- returns a URI-encoded "&amp;"
    because we pass XML in the URI, we have to escape this way -->
    <#return str?replace('&', '%26amp%3B')>
</#function>

<#assign courseWork = xml.getSubtree('local/courseWorkWrapper')>
<#assign courseWorkType = courseWork.get('courseWorkType')>
<#if courseWorkType == "Course work">
<dl>
    <#assign itemUuid = xml.get('item/@id')>
    <#assign itemversion = xml.get('item/@version')>
    <#assign itemAttachments = xml.getAllSubtrees('item/attachments/attachment')>
    <#assign powerSearch = 'Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4'>

    <#assign title = xml.get('mods/titleInfo/title')>
    <h2 id="title">${title}</h2>

    <#assign division = xml.get('local/division')>
    <#assign department = xml.get('local/department')>
    <#if division != "">
        <dt class="hide">Collection</dt>
        <#assign departmentUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=&sort=datemodified&dr=AFTER">
        <#assign divisionUrl = "/access/searching.do?in=${powerSearch}&q=&sort=datemodified&dr=AFTER" />
        <dd class="collection">
            <a href="${departmentUrl}">${department}</a> | <a href="${divisionUrl}">${division}</a>
        </dd>
    </#if>

    <#list xml.getAllSubtrees('mods/name') as name>
        <#assign namePart = name.get('namePart')>
        <#assign namePartUrl = '/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3Cname%3E%3CnamePart%3E${namePart}%3C%2FnamePart%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=${powerSearch}&q=&sort=datemodified&dr=AFTER'>
        <#if namePart != "">
            <dt>Creator</dt>
            <dd><a href="${namePartUrl}">${namePart}</a></dd>
        </#if>
    </#list>

    <#assign courseInfo = xml.getSubtree('local/courseInfo')>
    <#assign semester = courseInfo.get('semester')>
    <#assign course = courseInfo.get('course')>
    <#assign section = courseInfo.get('section')>
    <#assign faculties = courseInfo.list('faculty')>
    <#assign courseUrl = "/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3ECourse%20work%3C/courseWorkType%3E%3C/courseWorkWrapper%3E%3Cdepartment%3ETextiles%3C/department%3E%3C/local%3E%3Cmods%3E%3Cname%3E%3CnamePart/%3E%3C/name%3E%3C/mods%3E%3C/xml%3E&in=${powerSearch}&q=%22${course}%22">
    <#assign sectionUrl = "/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3ECourse%20work%3C/courseWorkType%3E%3C/courseWorkWrapper%3E%3Cdepartment%3ETextiles%3C/department%3E%3C/local%3E%3Cmods%3E%3Cname%3E%3CnamePart/%3E%3C/name%3E%3C/mods%3E%3C/xml%3E&in=${powerSearch}&q=%22${section}%22">
    <#assign semesterUrl = "/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3ECourse%20work%3C/courseWorkType%3E%3C/courseWorkWrapper%3E%3Cdepartment%3ETextiles%3C/department%3E%3C/local%3E%3Cmods%3E%3Cname%3E%3CnamePart/%3E%3C/name%3E%3C/mods%3E%3C/xml%3E&in=${powerSearch}&q=%22${semester}%22">
    <dt>Course Info</dt>
    <dd>
        <#if (semester != "")>
            <a href="${semesterUrl}">${semester}</a>
        </#if>
        <#if (course != "")>
            — <a href ="${courseUrl}">${course}</a>
        </#if>
        <#if (faculties?size != 0)>
            —
            <#list faculties as faculty>
                <#-- need to do this assignment inside of loop -->
                <#assign facultyUrl = "/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3ECourse%20work%3C/courseWorkType%3E%3C/courseWorkWrapper%3E%3Cdepartment%3ETextiles%3C/department%3E%3C/local%3E%3Cmods%3E%3Cname%3E%3CnamePart/%3E%3C/name%3E%3C/mods%3E%3C/xml%3E&in=${powerSearch}&q=%22${faculty}%22" />
                <a href ="${facultyUrl}">${faculty}</a><#if faculty_has_next>, </#if>
            </#list>
        </#if>
        <#if (section != "")>
            — <a href ="${sectionUrl}">${section}</a>
        </#if>
    </dd>

    <#assign abstract = xml.get('mods/abstract')>
    <#if (abstract != "")>
        <dt>Description</dt>
        <dd><pre>${abstract}</pre></dd>
    </#if>
</dl>
</#if>
