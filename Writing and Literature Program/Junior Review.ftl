<#function escapeAmp str>
    <#-- returns a URI-encoded "&amp;"
    because we are passing XML in the URI, we have to escape this way -->
    <#return str?replace('&', '%26amp%3B')>
</#function>
<#assign itemUuid = xml.get('item/@id')>
<#assign itemversion = xml.get('item/@version')>
<#assign itemAttachments = xml.getAllSubtrees('item/attachments/attachment')>
<#assign courseInfo = xml.getAllSubtrees('local/courseInfo')>
<#assign powerSearch = 'Pe78fd93a-86cd-40a9-9382-e86897646a2d'>


<#list xml.getAllSubtrees('local/courseWorkWrapper') as courseWork>
    <#assign type = courseWork.get('courseWorkType')>
    <#if type == 'Junior Review portfolio'>
    <dl>

        <#assign title = xml.get('mods/titleInfo/title')>
        <h2 id="title">${title}</h2>

        <dt class="hide">Collection</dt>
        <#assign division = xml.get('local/division')>
        <#assign department = xml.get('local/department')>
        <#assign divisionUrl = "/access/searching.do?in=${powerSearch}&q=&sort=datemodified&dr=AFTER" />
        <#assign departmentUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=&sort=datemodified&dr=AFTER"/>
        <dd class="collection">
            <a href="${departmentUrl}">${department}</a> | <a href="${divisionUrl}">${division}</a>
        </dd>
        <br/>

        <#list courseInfo as courseInfo>
            <#assign semester = courseInfo.get('semester')>
            <#assign course = courseInfo.get('course')>
            <#assign faculty = courseInfo.get('faculty')>
            <#assign section = courseInfo.get('section')>
            <#assign facultyUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Cfaculty%3E${faculty}%3C%2Ffaculty%3E%3C%2FcourseInfo%3E%3Cdepartment%3EWriting+and+Literature%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=&sort=datemodified&dr=AFTER" />
            <#assign courseUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Ccourse%3E${escapeAmp(course)}%3C%2Fcourse%3E%3C%2FcourseInfo%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3ECourse+work%3C%2FcourseWorkType%3E%3C%2FcourseWorkWrapper%3E%3Cdepartment%3EWriting+and+Literature%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=&sort=datemodified&dr=AFTER" />
            <#assign semesterUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Csemester%3E${semester}%3C%2Fsemester%3E%3C%2FcourseInfo%3E%3Cdepartment%3EWriting+and+Literature%3C%2Fdepartment%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3ECourse+work%3C%2FcourseWorkType%3E%3C%2FcourseWorkWrapper%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=&sort=datemodified&dr=AFTER" />
            <#assign sectionUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3ECourse+work%3C%2FcourseWorkType%3E%3C%2FcourseWorkWrapper%3E%3CcourseInfo%3E%3Csection%3E${section}%3C%2Fsection%3E%3C%2FcourseInfo%3E%3Cdepartment%3EWriting+and+Literature%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER" />
            <#if semester == ""><i>no course selected</i><#else>
                <dd><span id="WrLitcoursestuff"><strong>Course:</strong>
                <a href="${semesterUrl}">${semester}</a>
                     — <a href="${courseUrl}">${course}</a>
                     — <a href="${facultyUrl}">${faculty}</a>
                     — <a href="${sectionUrl}">${section}</a>
                </span></dd>
            </#if>
        </#list>

        <#list xml.getAllSubtrees('mods/name') as name>
            <#assign namePart = name.get('namePart')>
            <#if namePart != "">
                <dd><strong>Student:</strong> ${namePart}
            </#if>
            <#list name.getAllSubtrees('subNameWrapper') as subName>
                <#assign major = subName.get('major')>
                <#assign majorUrl = "/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3Cname%3E%3CsubNameWrapper%3E%3Cmajor%3E${major}%3C%2Fmajor%3E%3C%2FsubNameWrapper%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=${powerSearch}&q=&sort=datemodified&dr=AFTER" />
                <#if (major != "")>
                     — <a href="${majorUrl}">${major}</a>
                </#if>
            </#list>
                </dd>
        </#list>

        <#assign tags = xml.list('local/tags')>
        <#if (tags?size > 0)>
            <dd><strong>Keywords:</strong>
            <#list tags as tag>
                ${tag}<#if tag_has_next>, </#if>
            </#list>
            </dd>
        </#if>

        <dd><strong>Junior Review portfolio filename: </strong>
        <#list xml.getAllSubtrees('local/juniorReviewWrapper/file') as portfolioFile>
            <#list itemAttachments as itemAttachment>
                <#if portfolioFile.get('/') = itemAttachment.get('uuid')>
                    <#assign thumb = itemAttachment.get('thumbnail')>
                    <#assign full = itemAttachment.get('file')>
                    <#assign uuid = itemAttachment.get('uuid')>
                    <#if full != "">
                        <a href="/file/${itemUuid}/${itemversion}/${full}">${full}</a>
                    </#if>
                    </dd>
                </#if>
            </#list>
        </#list>

        <dd><strong>Artist Statement filename: </strong>
        <#list xml.getAllSubtrees('local/artistDocWrapper/artistStatementFile') as artistStatementFile>
            <#list itemAttachments as itemAttachment>
                <#if artistStatementFile.get('/') = itemAttachment.get('uuid')>
                    <#assign thumb = itemAttachment.get('thumbnail')>
                    <#assign full = itemAttachment.get('file')>
                    <#assign uuid = itemAttachment.get('uuid')>
                    <#if full != "">
                        <a href="/file/${itemUuid}/${itemversion}/${full}">${full}</a>
                    </#if>
                    </p>
                </#if>
            </#list>
        </#list>

</#if>
</#list>
