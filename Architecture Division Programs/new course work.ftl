<#assign itemUuid = xml.get('item/@id')>
<#assign itemversion = xml.get('item/@version')>
<#assign itemAttachments = xml.getAllSubtrees('item/attachments/attachment')>
<#assign powerSearch = 'Pafcc42be-462c-483e-b2ed-98ffcd15ff3d'>

<#list xml.getAllSubtrees('local/courseWorkWrapper') as courseWork>
<#assign courseWorkType = courseWork.get('courseWorkType')>
<#if courseWorkType == "Course work">
<dl>
    <#assign department = xml.get('local/department')>
    <#assign division = xml.get('local/division')>
    <dt class="hide">Division</dt>
    <#assign divisionUrl = "/access/searching.do?in=C1ca1ba6f-e327-4557-9b7e-25e1bba1b359&q=&type=standard&dr=AFTER">
    <dd class="collection">
        <#if department != "">
            <#assign departmentUrl = '/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}'>
            <a href="${departmentUrl}">${department}</a>&nbsp;|&nbsp;
        </#if>
        <a href="${divisionUrl}">${division}</a>
    </dd>

    <#assign title = xml.get('mods/titleInfo/title')>
    <h2 id="title">${title}</h2>

    <#list xml.getAllSubtrees('mods/name') as name>
        <#assign namePart = name.get('namePart')>
        <dd><strong>Student</strong>: ${namePart}
        <#list name.getAllSubtrees('subNameWrapper') as subName>
            <#assign major = subName.get('major')>
            <#assign majorUrl = "/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3Cname%3E%3CsubNameWrapper%3E%3Cmajor%3E${major}%3C%2Fmajor%3E%3C%2FsubNameWrapper%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER">
            <#if major != ""> -
                <a href="${majorUrl}">${major}</a>
            </#if>
        </#list>
        </dd>
    </#list>

    <#list xml.getAllSubtrees('local/courseInfo') as courseInfo>
        <#assign department = courseInfo.get('department')>
        <#assign semester = courseInfo.get('semester')>
        <#assign course = courseInfo.get('course')>
        <#assign faculty = courseInfo.get('faculty')>
        <#assign section = courseInfo.get('section')>
        <#assign courseCategory = courseInfo.get('courseCategory')>
        <#assign XList = courseInfo.get('XList')>
        <#assign courseUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Ccourse%3E${course}%3C%2Fcourse%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER">
        <#assign departmentUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER">
        <#assign semesterUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Csemester%3E${semester}%3C%2Fsemester%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER">
        <#assign facultyUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Cfaculty%3E${faculty}%3C%2Ffaculty%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER">
        <#assign sectionUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Csection%3E${section}%3C%2Fsection%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER">

        <#if semester != "" && semester != "undefined">
            <span id="coursestuff"><strong>Course</strong>:
                <a href="${semesterUrl}">${semester}</a>
                 — <a href="${departmentUrl}">${department}</a>
                 — <a href="${courseUrl}">${course}</a>
                 — <a href="${facultyUrl}">${faculty}</a>
                 — <a href="${sectionUrl}">${section}</a>
            </span>
            <span id="coursestuff">
                <#if XList != "">
                    (Cross-listed as ${XList}.)
                </#if>
            </span>
        </#if>
    </#list>

    <#assign courseWorkType = courseWork.get('courseWorkType')>
    <#assign courseWorkTypeSpecific = courseWork.get('courseWorkTypeSpecific')>
    <#assign groupProject = courseWork.get('groupProject')>
    <#assign groupProjectNumber = courseWork.get('groupProjectNumber')>
    <#assign groupConstituents = courseWork.list('groupConstituents')>
    <#assign projectTitle = courseWork.get('projectTitle')>
    <#assign courseWorkTypeUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3E${courseWorkType}%3C%2FcourseWorkType%3E%3C%2FcourseWorkWrapper%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER">
    <#assign groupProjectUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseWorkWrapper%3E%3CgroupProject%3E${groupProject}%3C%2FgroupProject%3E%3C%2FcourseWorkWrapper%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER">
    <#assign courseWorkTypeSpecificUrl = "">

    <dd><strong>Description</strong>:
    <#if courseWorkType != "">
        ${courseWorkType}
    </#if>
    <#if courseWorkType !="" && projectTitle != "">: </#if>
    <#if courseWorkTypeSpecific != "">
        ${courseWorkTypeSpecific}
    </#if>
    <#if projectTitle != "">
        number ${projectTitle}
    </#if>
    </dd>

    <#assign abstract = xml.get('mods/abstract')>
    <#if abstract != ""><dd>${abstract}</dd></#if>

    <#if groupProject != "">
        <dd><strong>This was a(n)</strong>: <a href="${groupProjectUrl}">${groupProject}</a></dd>
    </#if>
    <#if groupProjectNumber != "">
        <dd><strong>Group members' contribution</strong>: ${groupProjectNumber}</dd>
    </#if>

    <#if groupConstituents?size != 0>
        <dd><strong>Group members were</strong>: <#list groupConstituents as constituent>${constituent}<#if constituent_has_next>, </#if></#list></dd>
    </#if>

<div id='images'>
    <#list itemAttachments as itemAttachment>
        <#assign full = itemAttachment.get('file')>
        <#assign uuid = itemAttachment.get('uuid')>
        <div class="image-studentWork">
            <a href="/file/${itemUuid}/${itemversion}/${full}"><img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
            <#list xml.getAllSubtrees('mods/part') as part>
                <#assign file = part.get('number')>
                <#list part.getAllSubtrees('wrapperOther') as other>
                    <#assign format = other.get('format')>
                    <#assign formatSpecific = other.get('formatSpecific')>
                    <#assign assignNumber = other.get('assignNumber')>
                    <#assign exerciseNumber = other.get('exerciseNumber')>
                <#if file == uuid>
                    <p class='photoImagelist'>
                    <#if format != "">${format}</#if>
                    <#if format!=""><br></#if>
                    <#if formatSpecific != "">${formatSpecific}</#if>
                    <#if formatSpecific!=""><br></#if>
                    <#if assignNumber != "">Assgn: ${assignNumber}</#if>
                    <#if assignNumber!=""><br></#if>
                    <#if exerciseNumber != "">Exercise: ${exerciseNumber}</#if>
                    <#if exerciseNumber!=""><br></#if>
                    </p>
                </#if>
                </#list>
            </#list>
        </div>
    </#list>
    </div>
    <div style="clear:both;"></div>
</#if>
</#list>
