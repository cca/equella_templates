<#assign itemUuid = xml.get('item/@id')>
<#assign itemversion = xml.get('item/@version')>
<#assign mods = xml.getAllSubtrees('mods')>
<#assign titleInfo = xml.getAllSubtrees('mods/titleInfo')>
<#assign name = xml.getAllSubtrees('mods/name')>
<#assign subNameWrapper = xml.getAllSubtrees('mods/name/subNameWrapper')>
<#assign itemAttachments = xml.getAllSubtrees('item/attachments/attachment')>
<#assign courseInfo = xml.getAllSubtrees('local/courseInfo')>
<#assign courseWork = xml.getAllSubtrees('local/courseWorkWrapper')>
<#assign juniorReview = xml.getAllSubtrees('local/juniorReviewWrapper')>
<#assign local = xml.getAllSubtrees('local')>
<#assign artistDocs = xml.getAllSubtrees('local/artistDocWrapper')>

<dl>
<#list courseWork as courseWork>
    <#assign type = courseWork.get('courseWorkType')>
    <#if type=='Junior Review portfolio'>

        <#list titleInfo as titleInfo>
            <#assign title = titleInfo.get('title')>
            <h2 id="title">${title}
            </h2>
        </#list>

        <dt class="hide">Collection</dt>
        <#list local as local>
            <#assign division = local.get('division')>
            <#assign department = local.get('department')>
            <#-- <dd>${division} -->
            <#-- <dd>${department} -->
            <#assign divisionUrl = "/access/searching.do?in=Pe78fd93a-86cd-40a9-9382-e86897646a2d&q=&sort=datemodified&dr=AFTER" />
            <#assign departmentUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pe78fd93a-86cd-40a9-9382-e86897646a2d&q=&sort=datemodified&dr=AFTER"/>
            <dd class="collection"><a href="${departmentUrl}">${department}</a> | <a href="${divisionUrl}">${division}</a></dd>
        </#list>

<br/>

        <#list courseInfo as courseInfo>
            <#assign semester = courseInfo.get('semester')>
            <#assign course = courseInfo.get('course')>
            <#assign faculty = courseInfo.get('faculty')>
            <#-- <dd>${course} -->
            <#-- <dd>${semester} -->
            <#-- <dd>${faculty} -->
            <#assign facultyUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Cfaculty%3E${faculty}%3C%2Ffaculty%3E%3C%2FcourseInfo%3E%3Cdepartment%3EWriting+and+Literature%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pe78fd93a-86cd-40a9-9382-e86897646a2d&q=&sort=datemodified&dr=AFTER" />
            <#assign courseUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Ccourse%3E${course}%3C%2Fcourse%3E%3C%2FcourseInfo%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3ECourse+work%3C%2FcourseWorkType%3E%3C%2FcourseWorkWrapper%3E%3Cdepartment%3EWriting+and+Literature%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pe78fd93a-86cd-40a9-9382-e86897646a2d&q=&sort=datemodified&dr=AFTER" />
            <#assign semesterUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Csemester%3E${semester}%3C%2Fsemester%3E%3C%2FcourseInfo%3E%3Cdepartment%3EWriting+and+Literature%3C%2Fdepartment%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3ECourse+work%3C%2FcourseWorkType%3E%3C%2FcourseWorkWrapper%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pe78fd93a-86cd-40a9-9382-e86897646a2d&q=&sort=datemodified&dr=AFTER" />
            <dd><a href="${semesterUrl}">${semester}</a>  — <a href="${courseUrl}">${course}</a>  — <a href="${facultyUrl}">${faculty}</a></dd>
        </#list>

        <#list name as name>
            <#assign namePart = name.get('namePart')>
            <#if namePart != "">
                <dd><strong>Student:</strong> ${namePart}
            </#if>
            <#list name.getAllSubtrees('subNameWrapper') as subName>
                <#assign major = subName.get('major')>
                <#-- <dd>${major} -->
                <#assign majorUrl = "/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3Cname%3E%3CsubNameWrapper%3E%3Cmajor%3E${major}%3C%2Fmajor%3E%3C%2FsubNameWrapper%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=Pe78fd93a-86cd-40a9-9382-e86897646a2d&q=&sort=datemodified&dr=AFTER" />
                <#if (major != "")>
                     — <a href="${majorUrl}">${major}</a>
                </#if>
            </#list>
        </dd>
        </#list>

        <#assign tags = xml.getAllSubtrees('local/tags')>
        <#list local as local>
            <#assign tagsx = local.get('tags')>
            <#if tagsx != "">
                <dd><strong>Keywords:</strong>
                <#list tags as tags>
                    ${tags}<#if tags_has_next>, </#if>
                </#list></p>
            </#if>
        </#list>


        <dd><strong>Junior Review portfolio filename: </strong>
        <#list xml.getAllSubtrees('local/juniorReviewWrapper/file') as portfolioFile>
        <#list itemAttachments as itemAttachment>
        <#if portfolioFile.get('/') = itemAttachment.get('uuid')>
            <#assign thumb = itemAttachment.get('thumbnail')>
            <#assign full = itemAttachment.get('file')>
            <#assign uuid = itemAttachment.get('uuid')>
            <#if full != "">
                <a href="/file/${itemUuid}/${itemversion}/${full}" target="_blank">${full}</a>
            </#if>
            </p>
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
                <a href="/file/${itemUuid}/${itemversion}/${full}" target="_blank">${full}</a>
            </#if>
            </p>
        </#if>
        </#list>
        </#list>

<#else></#if>
</#list>
