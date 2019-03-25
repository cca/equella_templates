<#function escapeAmp str>
    <#-- returns a URI-encoded "&amp;"
    because we are passing XML in the URI, we have to escape this way -->
    <#return str?replace('&', '%26amp%3B')>
</#function>
<#assign itemUuid = xml.get('item/@id')>
<#assign itemversion = xml.get('item/@version')>
<#assign itemAttachments = xml.getAllSubtrees('item/attachments/attachment')>

<style>
a[href=""] {
    color: #4b4842; /* default text color */
    pointer-events: none;
}
</style>

<#list xml.getAllSubtrees('local/courseWorkWrapper') as courseWork>
    <#assign groupProject = courseWork.get('groupProject')>
    <#assign groupMembers = courseWork.get('groupMembers')>
    <#assign courseWorkType = courseWork.get('courseWorkType')>
    <#assign groupProjectUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseWorkWrapper%3E%3CgroupProject%3E${groupProject}%3C%2FgroupProject%3E%3C%2FcourseWorkWrapper%3E%3Cdepartment%3EGraphic+Design%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />
    <#assign courseWorkTypeUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3E${courseWorkType}%3C%2FcourseWorkType%3E%3C%2FcourseWorkWrapper%3E%3Cdepartment%3EGraphic+Design%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />
    <#if courseWorkType=="Course work">

    <dl>
        <#assign title = xml.get('mods/titleInfo/title')>
        <h2 id="title">${title}</h2>

        <dt class="hide">Collection</dt>
        <#list xml.getAllSubtrees('local') as local>
            <#assign division = local.get('division')>
            <#assign department = local.get('department')>
            <#assign divisionUrl = "/access/searching.do?doc=%3Cxml%2F%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />
            <#assign departmentUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />

            <dd class="collection"><a href="${departmentUrl}">${department}</a> | <a href="${divisionUrl}">${division}</a></dd>
        </#list>

        <div id="images">
        <#list itemAttachments as itemAttachment>
            <#assign uuid = itemAttachment.get('uuid')>
            <#assign full = itemAttachment.get('file')>
            <#if full?ends_with(".pdf")>
                <a href="/file/${itemUuid}/${itemversion}/${full}" class="pdf">
                <img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
            <#elseif ! full?contains("http://") && ! full?ends_with(".zip")>
                <a href="/file/${itemUuid}/${itemversion}/${full}" rel="group" class="img">
                <img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
            </#if>
        </#list>
        </div>

        <#list xml.getAllSubtrees('mods/name') as nameInfo>
            <#assign name = nameInfo.get('namePart')>
            <dt>Description</dt>
            <dd>${name}
            <#list nameInfo.getAllSubtrees('subNameWrapper') as subName>
                <#assign major = subName.get('major')>
                <#assign majorUrl = "/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3Cname%3E%3CsubNameWrapper%3E%3Cmajor%3E${major}%3C%2Fmajor%3E%3C%2FsubNameWrapper%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />
                <#if (major != "")>
                 — <a href="${majorUrl}">${major}</a>
                </#if>
            </#list>
            </dd>
        </#list>

        <#list xml.getAllSubtrees('local/courseInfo') as courseInfo>
            <#assign semester = courseInfo.get('semester')>
            <#assign course = courseInfo.get('course')>
            <#assign faculty = courseInfo.get('faculty')>
            <#assign section = courseInfo.get('section')>
            <#assign courseCategory = courseInfo.get('courseCategory')>
            <#assign specialPrograms = courseInfo.get('specialPrograms')>
            <#assign courseName = courseInfo.get('courseName')>
            <#assign XList = courseInfo.get('XList')>
            <#assign semesterUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Csemester%3E${semester}%3C%2Fsemester%3E%3C%2FcourseInfo%3E%3Cdepartment%3EGraphic+Design%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />
            <#assign courseUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Ccourse%3E${escapeAmp(course)}%3C%2Fcourse%3E%3C%2FcourseInfo%3E%3Cdepartment%3EGraphic+Design%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />
            <#assign facultyUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Cfaculty%3E${faculty}%3C%2Ffaculty%3E%3C%2FcourseInfo%3E%3Cdepartment%3EGraphic+Design%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />
            <#assign sectionUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Csection%3E${section}%3C%2Fsection%3E%3C%2FcourseInfo%3E%3Cdepartment%3EGraphic+Design%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />
            <#assign courseCategoryUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3CcourseCategory%3E${courseCategory}%3C%2FcourseCategory%3E%3CspecialPrograms%3E${specialPrograms}%3C%2FspecialPrograms%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />
            <#assign courseNameUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3CcourseName%3E${courseName}%3C%2FcourseName%3E%3C%2FcourseInfo%3E%3Cdepartment%3EGraphic+Design%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />
            <#assign XListUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3CXList%3E${XList}%3C%2FXList%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />

            <#if (semester == "")><i>no course selected</i><#else>
            <span id="coursestuff" style="font-size: 11.5px;">
                <a href="${semesterUrl}">${semester}</a>
                 — <a href="${courseUrl}">${course}</a>
                 — <a href="${facultyUrl}">${faculty}</a>
                 — <a href="${sectionUrl}">${section}</a>
            </span>
            </#if>

            <span id="coursestuff" style="font-size: 11.5px;">
                <#if XList!="">
                    Section cross-listed with <a href="${XListUrl}">${XList}</a>.
                </#if>
            </span>
            <span id="coursestuff" style="font-size: 11.5px;">
                Course number / category: <a href="${courseNameUrl}">${courseName}</a>
                <#if (courseCategory != "")>
                     — <a href="${courseCategoryUrl}">${courseCategory}</a>
                </#if>
            </span>
        </#list>

        <dd><a href="${courseWorkTypeUrl}">${courseWorkType}</a>

        <#list xml.getAllSubtrees('mods/physicalDescription') as physdesc>
            <#assign formBroad = physdesc.get('formBroad')>
            <#assign formSpecific = physdesc.get('formSpecific')>
            <#assign formBroadUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3ECourse+work%3C%2FcourseWorkType%3E%3C%2FcourseWorkWrapper%3E%3Cdepartment%3EGraphic+Design%3C%2Fdepartment%3E%3C%2Flocal%3E%3Cmods%3E%3CphysicalDescription%3E%3CformBroad%3E${formBroad}%3C%2FformBroad%3E%3C%2FphysicalDescription%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />
            <#assign formSpecificUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3ECourse+work%3C%2FcourseWorkType%3E%3C%2FcourseWorkWrapper%3E%3Cdepartment%3EGraphic+Design%3C%2Fdepartment%3E%3C%2Flocal%3E%3Cmods%3E%3CphysicalDescription%3E%3CformBroad%3E2D%3C%2FformBroad%3E%3CformSpecific%3E${formSpecific}%3C%2FformSpecific%3E%3C%2FphysicalDescription%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />
             — <a href="${formBroadUrl}">${formBroad}</a>
             — <a href="${formSpecificUrl}">${formSpecific}</a>
        </#list>
            </dd>

        <#list itemAttachments as itemAttachment>
            <#assign type = itemAttachment.get('@type')>
            <#assign full = itemAttachment.get('file')>
            <dd><#if type == "remote">
                Related link: <a href="${full}">${full}</a>
            </#if>
            </dd>
        </#list>

        <dd>
        <#if groupProject == "individual project">
            This was an <a href="${groupProjectUrl}">${groupProject}</a>.
        <#elseif groupProject == "group project">
            This was a <a href="${groupProjectUrl}">${groupProject}</a>
        </#if>
        <#if groupMembers != "">
            with ${groupMembers}.
        </#if>
        </dd>

        <#list xml.getAllSubtrees('local/creativeCommons') as copyright>
            <#assign type = copyright.get('type')>
            <#assign typeUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3Cdepartment%3EGraphic+Design%3C%2Fdepartment%3E%3CcreativeCommons%3E%3Ctype%3E${type}%3C%2Ftype%3E%3C%2FcreativeCommons%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />

            <dd>Copyright authorization: <a href="${typeUrl}">${type}</a></dd>
        </#list>
    </#if>
</#list>
