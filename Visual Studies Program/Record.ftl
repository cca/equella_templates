<#assign itemUuid = xml.get('item/@id')>
<#assign itemversion = xml.get('item/@version')>
<#assign mods = xml.getAllSubtrees('mods')>
<#assign titleInfo = xml.getAllSubtrees('mods/titleInfo')>
<#assign name = xml.getAllSubtrees('mods/name')>
<#assign subNameWrapper = xml.getAllSubtrees('mods/name/subNameWrapper')>
<#assign itemAttachments = xml.getAllSubtrees('item/attachments/attachment')>
<#assign courseInfo = xml.getAllSubtrees('local/courseInfo')>
<#assign courseWork = xml.getAllSubtrees('local/courseWorkWrapper')>
<#assign assignmentWrapper = xml.getAllSubtrees('local/assignmentWrapper')>
<#assign visStWrapper = xml.getAllSubtrees('local/visStWrapper')>
<#assign local = xml.getAllSubtrees('local')>

<#if xml.get('local/courseWorkWrapper/courseWorkType') == 'Course work'>

<dl>
<#list titleInfo as titleInfo>
    <#assign title = titleInfo.get('title')>
    <h2 id="title">${title}</h2>
</#list>

<dt class="hide">Collection</dt>
<#list local as local>
    <#assign departmentUrl = '/access/searching.do?in=C6fe8f55a-940e-4f26-a635-63b2b9995cd4&q=&type=standard'>
    <#assign division = local.get('division')>
    <#assign divisionUrl = "/access/searching.do?doc=%3Cxml%2F%3E&in=Pe78fd93a-86cd-40a9-9382-e86897646a2d&q=&sort=datemodified&dr=AFTER" />
    <dd class="collection">
        <a href="${departmentUrl}">${xml.get('local/department')}</a> | <a href="${divisionUrl}">${division}</a>
    </dd>
</#list>

<ul class="thumbnails">
<#list itemAttachments as itemAttachment>
    <#assign thumb = itemAttachment.get('thumbnail')>
    <#assign uuid = itemAttachment.get('uuid')>
    <#assign full = itemAttachment.get('file')>
    <#-- @TODO change #image-single rule in customer.css
    can't have multiple items with identical IDs on a page -->
    <li class="thumbnail">
        <a href="/file/${itemUuid}/${itemversion}/${full}"><img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
        <p class='caption'>${full}</p>
    </li>
</#list>
</ul>

<div style="clear:both;"></div>

<#list courseInfo as courseInfo>
    <#assign semester = courseInfo.get('semester')>
    <#assign course = courseInfo.get('course')>
    <#assign faculty = courseInfo.get('faculty')>
    <#assign section = courseInfo.get('section')>
    <#assign courseUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Ccourse%3E${course}%3C%2Fcourse%3E%3C%2FcourseInfo%3E%3Cdepartment%3EVisual+Studies%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pe78fd93a-86cd-40a9-9382-e86897646a2d&q=&sort=datemodified&dr=AFTER" />
    <#assign semesterUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3Cdepartment%3EVisual+Studies%3C%2Fdepartment%3E%3CcourseInfo%3E%3Csemester%3E${semester}%3C%2Fsemester%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pe78fd93a-86cd-40a9-9382-e86897646a2d&q=&sort=datemodified&dr=AFTER" />
    <#assign facultyUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Cfaculty%3E${faculty}%3C%2Ffaculty%3E%3C%2FcourseInfo%3E%3Cdepartment%3EVisual+Studies%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pe78fd93a-86cd-40a9-9382-e86897646a2d&q=&sort=datemodified&dr=AFTER" />
    <#assign sectionUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Csection%3E${section}%3C%2Fsection%3E%3C%2FcourseInfo%3E%3Cdepartment%3EVisual+Studies%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pe78fd93a-86cd-40a9-9382-e86897646a2d&q=&sort=datemodified&dr=AFTER" />
    <#if (semester != "")>
    <dd><strong>Course</strong>: <a href="${semesterUrl}">${semester}</a>
        <#if (course=="")>
            <#else> — <a href="${courseUrl}">${course}</a>
        </#if>
        <#list local as local>
            <#assign assess = local.get('accreditation')>
            <#if assess != "Spring 2014 assessment">
                <#if faculty != "">
                     — <a href="${facultyUrl}">${faculty}</a>
                </#if>
                <#if section != "">
                     — <a href="${sectionUrl}">${section}</a>
                </#if>
            </#if>
        </#list>
    </dd>
    </#if>
</#list>

<#list name as name>
    <#assign namePart = name.get('namePart')>
    <#if namePart != "">
        <dd><strong>Student:</strong> ${namePart}
    </#if>
    <#list name.getAllSubtrees('subNameWrapper') as subName>
        <#assign major = subName.get('major')>
        <#assign majorUrl = "/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3Cname%3E%3CsubNameWrapper%3E%3Cmajor%3E${major}%3C%2Fmajor%3E%3C%2FsubNameWrapper%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=Pe78fd93a-86cd-40a9-9382-e86897646a2d&q=&sort=datemodified&dr=AFTER" />
        <#if major != "">
             — <a href="${majorUrl}">${major}</a>
        </#if>
    </#list>
        </dd>
</#list>

<#list courseWork as courseWork>
    <#assign courseWorkType = courseWork.get('courseWorkType')>
    <#assign otherAssignCategory = courseWork.get('courseWorkTypeSpecific')>
    <#assign workType = courseWork.get('workType')>
    <#assign courseWorkTypeUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3Cdepartment%3EVisual+Studies%3C%2Fdepartment%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3E${courseWorkType}%3C%2FcourseWorkType%3E%3C%2FcourseWorkWrapper%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pe78fd93a-86cd-40a9-9382-e86897646a2d&q=&sort=datemodified&dr=AFTER" />
    <#assign otherAssignCategoryUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseWorkWrapper%3E%3CcourseWorkTypeSpecific%3E${otherAssignCategory}%3C%2FcourseWorkTypeSpecific%3E%3C%2FcourseWorkWrapper%3E%3Cdepartment%3EVisual+Studies%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pe78fd93a-86cd-40a9-9382-e86897646a2d&q=&sort=datemodified&dr=AFTER" />
    <#assign workTypeUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseWorkWrapper%3E%3CworkType%3E${workType}%3C%2FworkType%3E%3C%2FcourseWorkWrapper%3E%3Cdepartment%3EVisual+Studies%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pe78fd93a-86cd-40a9-9382-e86897646a2d&q=&sort=datemodified&dr=AFTER" />

    <#if courseWorkType == "other">
        <dd><strong>Assignment category:</strong> <a href="${otherAssignCategoryUrl}">${otherAssignCategory}</a></dd>
    <#else>

    </#if>
    <#if workType != "">
        <dd><strong>Syllabus title of assignment:</strong> <a href="${workTypeUrl}">${workType}</a></dd>
    </#if>
</#list>

<#list mods as mods>
    <#assign abstract = mods.get('abstract')>
    <#if abstract != "">
        <dd><strong>Additional notes: </strong>${abstract}</dd>
    </#if>
</#list>

</#if>
