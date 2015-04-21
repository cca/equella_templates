<#function escapeAmp str>
    <#-- returns a URI-encoded "&amp;"
    because we are passing XML in the URI, we have to escape this way -->
    <#return str?replace('&', '%26amp%3B')>
</#function>

<#list xml.getAllSubtrees('local/courseWorkWrapper') as courseWork>
<#assign courseWorkType = courseWork.get('courseWorkType')>
<#if courseWorkType == 'Course work' || courseWorkType == 'Events'>

<#assign powerSearch = 'Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4'>
<#assign itemUuid = xml.get('item/@id')>
<#assign itemversion = xml.get('item/@version')>

<dl>
    <#assign title = xml.get('mods/titleInfo/title')>
    <h2 id="title">${title}</h2>

    <dt class="hide">Collection</dt>
    <#assign department = xml.get('local/department')>
    <#assign division = xml.get('local/division')>
    <#assign divisionUrl = "/access/searching.do?in=${powerSearch}&q=&sort=datemodified&dr=AFTER">
    <#assign departmentUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER">
    <dd class="collection">
        <a href="${departmentUrl}">${department}</a> | <a href="${divisionUrl}">${division}</a>
    </dd>

    <#if courseWorkType == "Course work">
        <div id="images">
        <#list xml.getAllSubtrees('item/attachments/attachment') as attachment>
            <#assign full = attachment.get('file')>
            <#assign uuid = attachment.get('uuid')>
            <#list xml.getAllSubtrees('local/seniorPacketWrapper') as seniorPacket>
                <#assign title = seniorPacket.get('title')>
                <#assign jpgFile = seniorPacket.get('lowResFile')>
                <#if jpgFile == uuid>
                    <div class="image-with-metadata shorter">
                        <a href="/file/${itemUuid}/${itemversion}/${full}" target="_blank">
                        <img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
                        <p class="metadata">
                            <#if title != "">
                                <span class="title">${title}</span>
                            </#if>
                            <br>${full}
                        </p>
                    </div>
                </#if>
            </#list>
        </#list>
        </div>
    </#if>
    <div style="clear:both;"></div>

    <#list xml.getAllSubtrees('mods/name') as name>
        <#assign namePart = name.get('namePart')>
        <#if name_index == 0 && (namePart != "")>
            <dt>Creator(s)</dt>
        </#if>
        <#if namePart != "">
            <dd>${namePart}
        </#if>
        <#list name.getAllSubtrees('subNameWrapper') as subName>
            <#assign major = subName.get('major')>
            <#assign description = subName.get('description')>
            <#assign majorUrl = "/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3Cname%3E%3CsubNameWrapper%3E%3Cmajor%3E${major}%3C%2Fmajor%3E%3C%2FsubNameWrapper%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER" />
            <#if description != "">
                 — ${description}
            </#if>
            <#if major != "">
                 — <a href="${majorUrl}">${major}</a>
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
        <#assign semesterUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Csemester%3E${semester}%3C%2Fsemester%3E%3C%2FcourseInfo%3E%3Cdepartment%3EGlass%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&dr=AFTER" />
        <#assign courseUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Ccourse%3E${escapeAmp(course)}%3C%2Fcourse%3E%3C%2FcourseInfo%3E%3Cdepartment%3EGlass%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&dr=AFTER" />
        <#assign facultyUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Cfaculty%3E${faculty}%3C%2Ffaculty%3E%3C%2FcourseInfo%3E%3Cdepartment%3EGlass%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&dr=AFTER" />
        <#assign sectionUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Csection%3E${section}%3C%2Fsection%3E%3C%2FcourseInfo%3E%3Cdepartment%3EGlass%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&dr=AFTER" />
        <#if semester != "">
            <dt>Course Info</dt>
            <span id="coursestuff">
                <a href="${semesterUrl}">${semester}</a>
                <#if (course != "undefined" && course != "Events")>
                    — <a href="${courseUrl}">${course}</a>
                </#if>
                <#if faculty != "undefined" && faculty != "">
                    — <a href="${facultyUrl}">${faculty}</a>
                </#if>
                <#if section != "undefined" && section != "">
                    — <a href="${sectionUrl}">${section}</a>
                </#if>
            </span>
        </#if>
    </#list>

    <#list xml.getAllSubtrees('mods/physicalDescription') as physdesc>
        <#-- only one formBroad, multiple formSpecific -->
        <#assign formBroad = physdesc.get('formBroad')>
        <#assign formSpecifics = physdesc.list('formSpecific')>

        <#assign materials = xml.list('local/courseWorkWrapper/material')>
        <#assign processes = xml.list('local/courseWorkWrapper/process')>
        <#assign courseWorkTypeUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3E${courseWorkType}%3C%2FcourseWorkType%3E%3C%2FcourseWorkWrapper%3E%3Cdepartment%3EGlass%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER" />
        <#assign formBroadUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3E${courseWorkType}%3C%2FcourseWorkType%3E%3C%2FcourseWorkWrapper%3E%3Cdepartment%3EGlass%3C%2Fdepartment%3E%3C%2Flocal%3E%3Cmods%3E%3CphysicalDescription%3E%3CformBroad%3E${formBroad}%3C%2FformBroad%3E%3C%2FphysicalDescription%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER" />
        <dt>Description</dt>
        <dd><a href="${courseWorkTypeUrl}">${courseWorkType}</a>
        <#if formBroad != "">
             — <a href="${formBroadUrl}">${formBroad}</a>
        </#if>

        <#if formSpecifics?size != 0>
         —
            <#list formSpecifics as formSpecific>
                <#-- we need to use dept, courseWorkType, & formBroad here
                in order to get formSpecific to show up in Power Search -->
                <#assign formSpecificUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3E${courseWorkType}%3C%2FcourseWorkType%3E%3C%2FcourseWorkWrapper%3E%3Cdepartment%3EGlass%3C%2Fdepartment%3E%3C%2Flocal%3E%3Cmods%3E%3CphysicalDescription%3E%3CformSpecific%3E${formSpecific}%3C%2FformSpecific%3E%3CformBroad%3E${formBroad}%3C%2FformBroad%3E%3C%2FphysicalDescription%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER" />
                <a href="${formSpecificUrl}">${formSpecific}</a><#if formSpecific_has_next>, </#if>
            </#list>
        </#if>
        </dd>

        <#if materials?size != 0>
            <dd>Mixed media material(s):
            <#list materials as material>
                ${material}<#if material_has_next>, </#if>
            </#list>
            </dd>
        </#if>

        <#if processes?size != 0>
            <dd>Technique(s):
            <#list processes as process>
                <#-- URL requires (hard-coded) dept, courseWorkType, & formBroad -->
                <#assign processUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3E${courseWorkType}%3C%2FcourseWorkType%3E%3Cprocess%3E${process}%3C%2Fprocess%3E%3C%2FcourseWorkWrapper%3E%3Cdepartment%3EGlass%3C%2Fdepartment%3E%3C%2Flocal%3E%3Cmods%3E%3CphysicalDescription%3E%3CformBroad%3E${formBroad}%3C%2FformBroad%3E%3C%2FphysicalDescription%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER">
                <a href="${processUrl}">${process}</a><#if process_has_next>, </#if>
            </#list>
            </dd>
        </#if>
    </#list>

    <#list xml.getAllSubtrees('local/extentWrapper') as extentWrapper>
        <#assign height = extentWrapper.get('heightINCH')>
        <#assign width = extentWrapper.get('widthINCH')>
        <#assign depth = extentWrapper.get('depthINCH')>
        <#if height != "">
            <dd>Measurements (in inches): ${height}H x ${width}W x ${depth}D</dd>
        </#if>
    </#list>

    <#list xml.getAllSubtrees('mods/origininfo') as origininfo>
        <#assign dateCreated = origininfo.get('dateCreatedWrapper/dateCreated')>
        <dd>Date created:
            <#if dateCreated == "">
                <em>(No date given)</em>
            <#else>
                ${dateCreated}
            </#if>
        </dd>
    </#list>

    <#assign abstract = xml.get('mods/abstract')>
    <#if abstract != ""><dd>Additional notes: ${abstract}</dd></#if>

</dl>
</#if>
</#list>
