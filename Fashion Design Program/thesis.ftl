<#assign itemUuid = xml.get('item/@id')>
<#assign itemversion = xml.get('item/@version')>
<#assign titleInfo = xml.getAllSubtrees('mods/titleInfo')>
<#assign itemAttachments = xml.getAllSubtrees('item/attachments/attachment')>
<#assign name = xml.getAllSubtrees('mods/name')>
<#assign subNameWrapper = xml.getAllSubtrees('mods/name/subNameWrapper')>
<#assign physdesc = xml.getAllSubtrees('mods/physicalDescription')>
<#assign modslevel = xml.getAllSubtrees('mods')>
<#assign subject = xml.getAllSubtrees('mods/subject')>
<#assign relateditem = xml.getAllSubtrees('mods/relateditem')>
<#assign courseInfo = xml.getAllSubtrees('local/courseInfo')>
<#assign courseWork = xml.getAllSubtrees('local/courseWorkWrapper')>
<#assign local = xml.getAllSubtrees('local')>
<#assign origininfo = xml.getAllSubtrees('mods/origininfo')>
<#assign seniorPacketWrapper = xml.getAllSubtrees('local/seniorPacketWrapper')>
<#assign internshipWrapper = xml.getAllSubtrees('local/internshipWrapper')>

<dl>
<#list courseWork as courseWork>
<#assign courseWorkType = courseWork.get('courseWorkType')>
<#if (courseWorkType =="Senior thesis project")>

    <#list titleInfo as titleInfo>
        <#assign title = titleInfo.get('title')>
        <#assign subTitle = titleInfo.get('subTitle')>
        <h2 id="title">${title}
        </h2></dl>
    </#list>

    <dt class="hide">Collection</dt>
    <#list local as local>
        <#assign division = local.get('division')>
        <#assign divisionUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3Cdivision%3E${division}%3C%2Fdivision%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pb0cd301e-6adf-48c5-59aa-9a7a2e7f9834&q=&sort=rank&dr=AFTER" />
        <dd class="collection"><a href="${divisionUrl}">${division}</a></dd>
    </#list>


    <div id="images">
    <#list xml.getAllSubtrees('mods/part/number') as imageFile>
    <#list itemAttachments as itemAttachment>
        <#assign thumb = itemAttachment.get('thumbnail')>
        <#assign full = itemAttachment.get('file')>
        <#if imageFile.get('/') = itemAttachment.get('uuid')>
            <#if full?contains("http://") || full?ends_with(".zip")><#else>
                <a href="/file/${itemUuid}/${itemversion}/${full}">
                <img src="/file/${itemUuid}/${itemversion}/${thumb}"/></a>
            </#if>
        </#if>
    </#list>
    </#list>
    </div>


    <#assign name = xml.getAllSubtrees('mods/name')>
    <#list name as name>
        <#assign namePart = name.get('namePart')>
        <#if name_index==0 && (namePart !="")>
            <dt>Creator</dt><#else>
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
        <#assign department = courseInfo.get('department')>
        <#assign semester = courseInfo.get('semester')>
        <#assign course = courseInfo.get('course')>
        <#assign faculty = courseInfo.get('faculty')>
        <#assign section = courseInfo.get('section')>
        <#assign courseCategory = courseInfo.get('courseCategory')>
        <#assign courseUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Ccourse%3E${course}%3C%2Fcourse%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pb0cd301e-6adf-48c5-59aa-9a7a2e7f9834&q=&sort=rank&dr=AFTER" />
        <#assign semesterUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Csemester%3E${semester}%3C%2Fsemester%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pb0cd301e-6adf-48c5-59aa-9a7a2e7f9834&q=&sort=rank&dr=AFTER" />
        <#assign facultyUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Cfaculty%3E${faculty}%3C%2Ffaculty%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pb0cd301e-6adf-48c5-59aa-9a7a2e7f9834&q=&sort=rank&dr=AFTER" />
        <#assign sectionUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Csection%3E${section}%3C%2Fsection%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pb0cd301e-6adf-48c5-59aa-9a7a2e7f9834&q=&sort=rank&dr=AFTER" />
        <#assign courseCategoryUrl = "" />
        <dt>Course Info</dt>
        <span id="coursestuff"><a href="${semesterUrl}">${semester}</a>
        <#if (course=="undefined") || (course=="Events")>
            <#else> — <a href="${courseUrl}">${course}</a>
        </#if>
        <#if faculty=="undefined">
            <#else> — <a href="${facultyUrl}">${faculty}</a>
        </#if>
        <#if section=="undefined">
            <#else> — <a href="${sectionUrl}">${section}</a>
        </#if>
        </span>
    </#list>

        <#assign workType = courseWork.get('workType')>
        <#assign courseWorkTypeSpecific = courseWork.get('courseWorkTypeSpecific')>
        <#assign courseWorkTypeUrl = "" />
        <#assign workTypeUrl = "" />
        <#assign courseWorkTypeSpecificUrl = "" />
        <dt>Description</dt>
        <dd>
        <#if courseWorkType=="">{undefined submission type}<#else>
            <a href="${courseWorkTypeUrl}">${courseWorkType}</a>
        </#if>

        <#list seniorPacketWrapper as seniorPacketWrapper>
            <#assign phase = seniorPacketWrapper.get('phase')>
            <#assign phaseUrl = "" />
                 — <a href="${phaseUrl}">${phase}</a>
        </#list>

        <#assign tags = xml.getAllSubtrees('local/tags')>
        <#list local as local>
            <#assign theme = local.get('theme')>
            <#assign tagx = local.get('tags')>
            <#assign tagUrl = "" />
            <#assign themeUrl = "" />
             — <a href="${themeUrl}">${theme}</a>
            <#if tagx==""><#else>
                 — <#list tags as tags>
                    <a href="${tagUrl}">${tags}</a><#if tags_has_next>, </#if>
                </#list>
            </#if>
        </#list>
        </dd>

        <#list modslevel as mods>
            <#assign abstract = mods.get('abstract')>
            <#if (abstract != "")>
                <dd>${abstract}</dd>
            </#if>
        </#list>

    <#list itemAttachments as itemAttachment>
        <#assign type = itemAttachment.get('@type')>
        <#assign full = itemAttachment.get('file')>
        <dd><#if type=="remote">
            Related link: <a href="${full}">${full}
            </a>
            </#if>
        </dd>
    </#list>

    <#list xml.getAllSubtrees('local/artistDocWrapper/resumeCVFile') as resumeCVFile>
        <#list itemAttachments as itemAttachment>
        <#if resumeCVFile.get('/') = itemAttachment.get('uuid')>
            <#assign thumb = itemAttachment.get('thumbnail')>
            <#assign full = itemAttachment.get('file')>
            <#assign uuid = itemAttachment.get('uuid')>
            <dt>Resume/CV</dt>
            <div class="image-artistDocs">
            <a href="/file/${itemUuid}/${itemversion}/${full}" target="_blank">
            <img src="/file/${itemUuid}/${itemversion}/${thumb}"/></a>
            <p class='artistDocs'>${full}</p>
            </div>
        </#if>
        </#list>
    </#list>

    <#assign location = xml.getAllSubtrees('/local/internshipWrapper/location')>
        <#list internshipWrapper as internshipWrapper>
            <#assign locationx = internshipWrapper.get('location')>
            <#if locationx==""><#else>
            <dd><strong>Career placement</strong>:
                <#list location as location>
                    ${location}</a><#if location_has_next>, </#if>
                </#list>
            </#if>
        </#list>
        </dd>

</#if>
</#list>
