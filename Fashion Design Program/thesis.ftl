<#function escapeAmp str>
    <#-- returns a URI-encoded "&amp;"
    because we are passing XML in the URI, we have to escape this way -->
    <#return str?replace('&', '%26amp%3B')>
</#function>
<#assign itemUuid = xml.get('item/@id')>
<#assign itemversion = xml.get('item/@version')>
<#assign itemAttachments = xml.getAllSubtrees('item/attachments/attachment')>
<#assign courseInfo = xml.getAllSubtrees('local/courseInfo')>
<#assign courseWork = xml.getAllSubtrees('local/courseWorkWrapper')>

<#list courseWork as courseWork>
<#assign courseWorkType = courseWork.get('courseWorkType')>
<#if courseWorkType == "Senior thesis project">
<dl>

    <#assign title = xml.get('mods/titleInfo/title')>
    <#assign subTitle = xml.get('mods/titleInfo/subTitle')>
    <h2 id="title">${title}</h2></dl>

    <dt class="hide">Collection</dt>
    <#assign division = xml.get('local/division')>
    <#assign divisionUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3Cdivision%3E${division}%3C%2Fdivision%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pb0cd301e-6adf-48c5-59aa-9a7a2e7f9834&q=&sort=rank&dr=AFTER">
    <#assign department = xml.get('local/department')>
    <#assign departmentUrl = "/access/searching.do?in=C875c9189-6e48-40f2-a00e-c64bc714440c&q=&type=standard&dr=AFTER">
    <dd class="collection">
        <a href="${departmentUrl}">${department}</a> | <a href="${divisionUrl}">${division}</a>
    </dd>

    <div id="images">
    <#list xml.list('local/seniorPacketWrapper/fileTypeA') as imageFile>
        <#list itemAttachments as itemAttachment>
            <#assign full = itemAttachment.get('file')>
            <#assign uuid = itemAttachment.get('uuid')>
            <#if imageFile == uuid>
                <#if ! full?contains("http://") && ! full?ends_with(".zip")>
                    <a href="/file/${itemUuid}/${itemversion}/${full}" rel="group">
                    <img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
                </#if>
            </#if>
        </#list>
    </#list>
    </div>

    <#list xml.getAllSubtrees('mods/name') as name>
        <#assign namePart = name.get('namePart')>
        <#if name_index == 0 && (namePart != "")>
            <dt>Creator</dt>
        </#if>
        <#if (namePart != "")>
            <dd>${namePart}
        </#if>
        <#list name.getAllSubtrees('subNameWrapper') as subName>
            <#assign major = subName.get('major')>
            <#assign affiliation = subName.get('affiliation')>
            <#assign majorUrl = "/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3Cname%3E%3CsubNameWrapper%3E%3Cmajor%3E${major}%3C%2Fmajor%3E%3C%2FsubNameWrapper%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />
            <#if (major != "")>
                 — <a href="${majorUrl}">${major}</a>
            </#if>
        </#list>
        </dd>
    </#list>

    <#list courseInfo as courseInfo>
        <#assign semester = courseInfo.get('semester')>
        <#assign course = courseInfo.get('course')>
        <#assign faculty = courseInfo.get('faculty')>
        <#assign section = courseInfo.get('section')>
        <#assign courseUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Ccourse%3E${escapeAmp(course)}%3C%2Fcourse%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pb0cd301e-6adf-48c5-59aa-9a7a2e7f9834&q=&sort=rank&dr=AFTER" />
        <#assign semesterUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Csemester%3E${semester}%3C%2Fsemester%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pb0cd301e-6adf-48c5-59aa-9a7a2e7f9834&q=&sort=rank&dr=AFTER" />
        <#assign facultyUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Cfaculty%3E${faculty}%3C%2Ffaculty%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pb0cd301e-6adf-48c5-59aa-9a7a2e7f9834&q=&sort=rank&dr=AFTER" />
        <#assign sectionUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Csection%3E${section}%3C%2Fsection%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pb0cd301e-6adf-48c5-59aa-9a7a2e7f9834&q=&sort=rank&dr=AFTER" />
        <dt>Course Info</dt>
        <span id="coursestuff"><a href="${semesterUrl}">${semester}</a>
        <#if (course != "undefined") && (course != "Events")>
            — <a href="${courseUrl}">${course}</a>
        </#if>
        <#if faculty != "undefined" && faculty != "">
            — <a href="${facultyUrl}">${faculty}</a>
        </#if>
        <#if section != "undefined" && section != "">
            — <a href="${sectionUrl}">${section}</a>
        </#if>
        </span>
    </#list>

    <dt>Description</dt>
    <dd>
    <#if courseWorkType == "">{undefined submission type}<#else>
        <#assign courseWorkTypeUrl = "" />
        <a href="${courseWorkTypeUrl}">${courseWorkType}</a>
    </#if>

    <#assign phase = xml.get('local/seniorPacketWrapper/phase')>
    <#if phase != "">
        <#assign phaseUrl = "">
         <a href="${phaseUrl}">— ${phase}</a>
     </#if>

    <#assign duration = xml.get('local/seniorPacketWrapper/duration')>
    <#if duration != "">
        <#assign durationUrl = "">
         <a href="${durationUrl}">— ${duration}</a>
     </#if>

    <#assign theme = xml.get('local/theme')>
    <#if theme != "">
        <#assign themeUrl = "">
     — <a href="${themeUrl}">${theme}</a>
     </#if>
     </dd>

     <#assign tags = xml.list('local/tags')>
    <#if tags?size != 0>
        <dd><b>Keywords</b>:
         <#list tags as tag>
            <#assign tagUrl = "" />
            <a href="${tagUrl}">${tag}</a><#if tag_has_next>, </#if>
        </#list>
        </dd>
    </#if>

    <#assign marketCategory = courseWork.get('courseWorkTypeSpecific')>
    <#if marketCategory != "">
        <dd><b>Market Category</b>: ${marketCategory}</dd>
    </#if>

    <#assign specialization = courseWork.get('process')>
    <#if specialization != "">
        <dd><b>Additional Specialization</b>: ${specialization}</dd>
    </#if>

    <#assign sustainability = courseWork.get('assignmentDescription')>
    <#if sustainability != "">
        <dd><b>Sustainability Details</b>: ${sustainability}</dd>
    </#if>

    <#assign abstract = xml.get('mods/abstract')>
    <#if (abstract != "")>
        <dd><b>Thesis:</b> ${abstract}</dd>
    </#if>

    <#list itemAttachments as itemAttachment>
        <dd><#if itemAttachment.get('@type') == "remote">
                <#assign full = itemAttachment.get('file')>
                Related link: <a href="${full}">${full}</a>
        </#if></dd>
    </#list>

    <#assign resumeCVFile = xml.get('local/artistDocWrapper/resumeCVFile')>
    <#list itemAttachments as itemAttachment>
        <#assign uuid = itemAttachment.get('uuid')>
        <#if resumeCVFile == uuid>
            <#assign full = itemAttachment.get('file')>
            <dt>Resume/CV</dt>
            <div class="image-artistDocs">
                <a href="/file/${itemUuid}/${itemversion}/${full}" target="_blank">
                <img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
                <p class="artistDocs">${full}</p>
            </div>
        </#if>
    </#list>

    <#assign locations = xml.list('/local/internshipWrapper/location')>
    <#if locations?size != 0>
    <dd><strong>Career placement</strong>:
        <#list locations as location>
            ${location}</a><#if location_has_next>, </#if>
        </#list>
    </dd>
    </#if>

</#if>
</#list>
