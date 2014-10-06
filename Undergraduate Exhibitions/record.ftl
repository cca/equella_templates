<#assign itemUuid = xml.get('item/@id')>
<#assign itemversion = xml.get('item/@version')>
<#assign itemAttachments = xml.getAllSubtrees('item/attachments/attachment')>
<#assign name = xml.getAllSubtrees('mods/name')>
<#assign subNameWrapper = xml.getAllSubtrees('mods/name/subNameWrapper')>
<#assign exhibitWrapper = xml.getAllSubtrees('local/exhibitWrapper')>
<#assign local = xml.getAllSubtrees('local')>
<#assign projectWrapper = xml.getAllSubtrees('local/projectWrapper')>
<#assign courseInfo = xml.getAllSubtrees('local/courseInfo')>

<dl>
    <#assign title = xml.get('mods/titleInfo/title')>
    <h2 id="title">${title}</h2>

<#assign date = xml.getAllSubtrees('local/exhibitWrapper/date')>
<#list exhibitWrapper as exhibitWrapper>
    <#assign gallery = exhibitWrapper.get('gallery')>
    <#assign semester = exhibitWrapper.get('semester')>
    <#assign sponsor = exhibitWrapper.get('sponsor')>
    <#assign showType = exhibitWrapper.get('@type')>
    <#assign datex = exhibitWrapper.get('date')>
    <#-- @todo fix these URLs -->
    <#assign galleryUrl = "" />
    <#assign semesterUrl = "" />
    <#assign showTypeUrl = "" />
    <#if semester != "">
        <dd style="font-size: 14px;"><strong>${semester}
    </#if>
    <#if gallery != "">
         —  ${gallery}
    </#if>
    <#if showType != "">
         —  ${showType}</strong></dd>
    </#if>
    <#if datex != "">
        <dd><strong>
            <#list date as date>${date}<#if date_has_next> through </#if>
            </#list>
        </strong></dd>
    </#if>

    <#list courseInfo as courseInfo>
        <#assign department = courseInfo.get('department')>
        <#assign semester = courseInfo.get('semester')>
        <#assign course = courseInfo.get('course')>
        <#assign faculty = courseInfo.get('faculty')>
        <#assign section = courseInfo.get('section')>
        <#assign courseCategory = courseInfo.get('courseCategory')>
        <#assign courseName = courseInfo.get('courseName')>
        <#assign XList = courseInfo.get('XList')>
        <#assign specialPrograms = courseInfo.get('specialPrograms')>
        <#assign specialProgramsUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3CcourseCategory%3E${specialPrograms}%3C%2FcourseCategory%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P618ad8c6-bc89-4f95-89e6-bc5225e38996&q=&sort=datemodified&dr=AFTER" />
        <#assign courseUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Ccourse%3E${course}%3C%2Fcourse%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P618ad8c6-bc89-4f95-89e6-bc5225e38996&q=&sort=datemodified&dr=AFTER" />
        <#assign departmentUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P618ad8c6-bc89-4f95-89e6-bc5225e38996&q=&sort=datemodified&dr=AFTER" />
        <#assign semesterUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Csemester%3E${semester}%3C%2Fsemester%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P618ad8c6-bc89-4f95-89e6-bc5225e38996&q=&sort=datemodified&dr=AFTER" />
        <#assign facultyUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Cfaculty%3E${faculty}%3C%2Ffaculty%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P618ad8c6-bc89-4f95-89e6-bc5225e38996&q=&sort=datemodified&dr=AFTER" />
        <#assign sectionUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Csection%3E${section}%3C%2Fsection%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P618ad8c6-bc89-4f95-89e6-bc5225e38996&q=&sort=datemodified&dr=AFTER" />
        <#assign courseCategoryUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3CcourseCategory%3E${courseCategory}%3C%2FcourseCategory%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P618ad8c6-bc89-4f95-89e6-bc5225e38996&q=&sort=datemodified&dr=AFTER" />
        <#assign courseNameUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3CcourseName%3E${courseName}%3C%2FcourseName%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P618ad8c6-bc89-4f95-89e6-bc5225e38996&q=&sort=datemodified&dr=AFTER" />
        <#assign XListUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3CXList%3E${XList}%3C%2FXList%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P618ad8c6-bc89-4f95-89e6-bc5225e38996&q=&sort=datemodified&dr=AFTER" />
        <#if sponsor=="course">
            <dd><span id="VisStcoursestuff">
                Sponsoring course: <a href="${semesterUrl}">${semester}</a>
                 — <a href="${departmentUrl}">${department}</a>
                 — <a href="${courseUrl}">${course}</a>
                 — <a href="${facultyUrl}">${faculty}</a>
                 — <a href="${sectionUrl}">${section}</a>
            </dd>
            <#if (XList!="undefined")&&(XList!="")>
                <dd><span id="VisStcoursestuff">
                    Course is cross-listed with <a href="${XListUrl}">${XList}</a>.
                </dd>
            </#if>
            <#if (courseCategory != "")>
                <dd><span id="VisStcoursestuff">Course category:
                    <a href="${courseCategoryUrl}">${courseCategory}</a>
            </#if>
            <#if (specialPrograms!="")>
                &amp; <a href="${specialProgramsUrl}">${specialPrograms}</a>
            </#if>
            </dd>
        <#elseif sponsor=="department / program">
            <#if department != 'undefined'>
                <dd>Sponsoring department / program: <a href="${departmentUrl}">${department}</a></dd>
            </#if>
        <#elseif sponsor=="student club">
            <#list local as local>
                <#assign studentClub = local.get('studentClub')>
                <dd>Sponsoring student club: ${studentClub}</dd>
            </#list>
        </#if>
    </#list>
</#list>

<#list name as name>
    <#assign namePart = name.get('namePart')>
    <dd>${namePart}
    <#list subNameWrapper as subName>
        <#assign major = subName.get('major')>
        <#assign gradDate = subName.get('gradDate')>
        <#assign majorUrl = "" />
        <#assign gradDateUrl = "" />
        <#if (major != "")>
             — ${major}
        </#if>
        <#if (major != "") && (gradDate != "")>, ${gradDate}
        </#if>
    </#list>
    </dd>
</#list>

<dd><i><u>Installation shots</i></u></dd>
<#list itemAttachments as itemAttachment>
    <#assign full = itemAttachment.get('file')>
    <#assign uuid = itemAttachment.get('uuid')>
    <#list projectWrapper as projectWrapper>
        <#assign title = projectWrapper.get('title')>
        <#assign artistName = projectWrapper.get('artistName')>
        <#assign semester = projectWrapper.get('semester')>
        <#assign formatSpecific = projectWrapper.get('formatSpecific')>
        <#assign dimensions = projectWrapper.get('dimensions')>
        <#assign keyword = projectWrapper.get('keyword')>
        <#assign fileA = projectWrapper.get('fileA')>
        <#if fileA==uuid>
            <#if full?ends_with(".zip")><#else>
            <div class="image-undergradExhibit">
                <a href="/file/${itemUuid}/${itemversion}/${full}" target="_blank"><img src="/thumbs/${itemUuid}/${itemversion}/${uuid}" width="88" height="66"/></a>
                <p class='photoImagelist'>
                    <#if title != ""><i>${title}</i><br /></#if>
                    <#if artistName != ""><i>${artistName}</i><br /></#if>
                    <#if semester != "">${semester}<br /></#if>
                    <#if keyword != "">${keyword}<br /></#if>
                    <#if formatSpecific != "">${formatSpecific}<br /></#if>
                    <#if dimensions != "">${dimensions}</#if>
                </p>
            </div>
            </#if>
        </#if>
    </#list>
</#list>
</div>

<#list xml.getAllSubtrees('local/exhibitWrapper/showcardFile') as showcardFile>
<#list itemAttachments as itemAttachment>
    <#if showcardFile.get('/') = itemAttachment.get('uuid')>
        <#assign full = itemAttachment.get('file')>
        <#assign uuid = itemAttachment.get('uuid')>
        <div class="image-artistDocs clearfix">
        <dd><i><u>Show card</i></u></dd>
        <a href="/file/${itemUuid}/${itemversion}/${full}" target="_blank">
        <img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
        </div>
    </#if>
</#list>
</#list>

<h4><i><strong>To view images as a slideshow, click on titles below.</strong></i></h4>
</dl>
