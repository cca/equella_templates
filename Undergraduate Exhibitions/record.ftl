<#assign itemUuid = xml.get('item/@id')>
<#assign itemversion = xml.get('item/@version')>
<#assign itemAttachments = xml.getAllSubtrees('item/attachments/attachment')>
<#-- @todo points at Syllabus Collection power search & is only used
for courseInfo dynamic links—is this a sensible decision?
only 1 item right now sponsored by course anyways, low priority
https://vault.cca.edu/items/223fd80a-c540-49d5-b359-9c29bee548de/1/ -->
<#assign powerSearch = 'P618ad8c6-bc89-4f95-89e6-bc5225e38996'>

<dl>
    <#assign title = xml.get('mods/titleInfo/title')>
    <h2 id="title">${title}</h2>

<#list xml.getAllSubtrees('local/exhibitWrapper') as exhibitWrapper>
    <#assign gallery = exhibitWrapper.get('gallery')>
    <#assign semester = exhibitWrapper.get('semester')>
    <#assign sponsor = exhibitWrapper.get('sponsor')>
    <#assign showType = exhibitWrapper.get('@type')>
    <#assign dates = exhibitWrapper.list('date')>
    <#-- @todo fix these URLs -->
    <#assign galleryUrl = "">
    <#assign semesterUrl = "">
    <#assign showTypeUrl = "">
    <#if semester != "">
        <dd style="font-size: 14px;"><strong>${semester}
    </#if>
    <#if gallery != "">
         —  ${gallery}
    </#if>
    <#if showType != "">
         —  ${showType}</strong></dd>
    </#if>
    <#if dates?size != 0>
        <dd><strong>
            <#list dates as date>${date}<#if date_has_next> through </#if>
            </#list>
        </strong></dd>
    </#if>

    <#list xml.getAllSubtrees('local/courseInfo') as courseInfo>
        <#assign department = courseInfo.get('department')>
        <#assign semester = courseInfo.get('semester')>
        <#assign course = courseInfo.get('course')>
        <#assign faculty = courseInfo.get('faculty')>
        <#assign section = courseInfo.get('section')>
        <#assign courseCategory = courseInfo.get('courseCategory')>
        <#assign courseName = courseInfo.get('courseName')>
        <#assign XList = courseInfo.get('XList')>
        <#assign specialPrograms = courseInfo.get('specialPrograms')>
        <#assign specialProgramsUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3CcourseCategory%3E${specialPrograms}%3C%2FcourseCategory%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=">
        <#assign courseUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Ccourse%3E${course}%3C%2Fcourse%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=">
        <#assign departmentUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=">
        <#assign semesterUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Csemester%3E${semester}%3C%2Fsemester%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=">
        <#assign facultyUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Cfaculty%3E${faculty}%3C%2Ffaculty%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=">
        <#assign sectionUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Csection%3E${section}%3C%2Fsection%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=">
        <#assign courseCategoryUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3CcourseCategory%3E${courseCategory}%3C%2FcourseCategory%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=">
        <#assign courseNameUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3CcourseName%3E${courseName}%3C%2FcourseName%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=">
        <#assign XListUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3CXList%3E${XList}%3C%2FXList%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=">
        <#if sponsor == "course">
            <dd><span id="VisStcoursestuff">
                Sponsoring course: <a href="${semesterUrl}">${semester}</a>
                 — <a href="${departmentUrl}">${department}</a>
                 — <a href="${courseUrl}">${course}</a>
                 — <a href="${facultyUrl}">${faculty}</a>
                 — <a href="${sectionUrl}">${section}</a>
            </dd>
            <#if (XList != "undefined" && XList != "")>
                <dd><span id="VisStcoursestuff">
                    Course is cross-listed with <a href="${XListUrl}">${XList}</a>.
                </dd>
            </#if>
            <#if courseCategory != "">
                <dd><span id="VisStcoursestuff">Course category:
                    <a href="${courseCategoryUrl}">${courseCategory}</a>
            </#if>
            <#if specialPrograms != "">
                &amp; <a href="${specialProgramsUrl}">${specialPrograms}</a>
            </#if>
            </dd>
        <#elseif sponsor == "department / program">
            <#if department != 'undefined'>
                <dd>Sponsoring department / program: <a href="${departmentUrl}">${department}</a></dd>
            </#if>
        <#elseif sponsor == "student club">
            <#assign studentClub = xml.get('local/studentClub')>
            <dd>Sponsoring student club: ${studentClub}</dd>
        </#if>
    </#list>
</#list>

<#list xml.getAllSubtrees('mods/name') as name>
    <#assign namePart = name.get('namePart')>
    <dd>${namePart}
    <#list xml.getAllSubtrees('mods/name/subNameWrapper') as subName>
        <#assign major = subName.get('major')>
        <#assign gradDate = subName.get('gradDate')>
        <#assign majorUrl = "">
        <#assign gradDateUrl = "">
        <#if major != "">
             — ${major}
        </#if>
        <#if (major != "" && gradDate != "")>, ${gradDate}</#if>
    </#list>
    </dd>
</#list>

<dd><i><u>Installation shots</i></u></dd>
<div class="clearfix">
<#list itemAttachments as itemAttachment>
    <#assign full = itemAttachment.get('file')>
    <#assign uuid = itemAttachment.get('uuid')>
    <#list xml.getAllSubtrees('local/projectWrapper') as projectWrapper>
        <#assign title = projectWrapper.get('title')>
        <#assign artistName = projectWrapper.get('artistName')>
        <#assign semester = projectWrapper.get('semester')>
        <#assign dimensions = projectWrapper.get('dimensions')>
        <#assign keywords = projectWrapper.list('keyword')>
        <#assign fileA = projectWrapper.get('fileA')>
        <#if fileA == uuid>
            <#if full?ends_with(".zip")><#else>
            <div class="image-with-metadata shorter">
                <a href="/file/${itemUuid}/${itemversion}/${full}" target="_blank"><img src="/thumbs/${itemUuid}/${itemversion}/${uuid}" width="88" height="66"></a>
                <p class="metadata">
                    <#if title != ""><span class="title">${title}</span><br></#if>
                    <#if artistName != "">by ${artistName}<br></#if>
                    <#if semester != "">${semester}<br></#if>
                    <#if keywords?size != 0>
                        <#list keywords as keyword>
                            ${keyword}<#if keyword_has_next>, </#if>
                        </#list><br>
                    </#if>
                    <#if dimensions != "">${dimensions}</#if>
                </p>
            </div>
            </#if>
        </#if>
    </#list>
</#list>
</div>

<#list xml.list('local/exhibitWrapper/showcardFile') as showcardFile>
<#list itemAttachments as itemAttachment>
    <#if showcardFile == itemAttachment.get('uuid')>
        <#assign full = itemAttachment.get('file')>
        <#assign uuid = itemAttachment.get('uuid')>
        <dd><i><u>Show card</i></u></dd>
        <div>
            <a href="/file/${itemUuid}/${itemversion}/${full}">
            <img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
        </div>
    </#if>
</#list>
</#list>

<h4 class="clearfix"><i><strong>To view images as a slideshow, click on titles below.</strong></i></h4>
</dl>
