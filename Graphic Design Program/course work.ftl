<#assign itemUuid = xml.get('item/@id')>
<#assign itemversion = xml.get('item/@version')>
<#assign titleInfo = xml.getAllSubtrees('mods/titleInfo')>
<#assign itemAttachments = xml.getAllSubtrees('item/attachments/attachment')>
<#assign nameInfo = xml.getAllSubtrees('mods/name')>
<#assign subNameWrapper = xml.getAllSubtrees('mods/name/subNameWrapper')>
<#assign physdesc = xml.getAllSubtrees('mods/physicalDescription')>
<#assign modslevel = xml.getAllSubtrees('mods')>
<#assign subject = xml.getAllSubtrees('mods/subject')>
<#assign relateditem = xml.getAllSubtrees('mods/relateditem')>
<#assign courseInfo = xml.getAllSubtrees('local/courseInfo')>
<#assign courseWork = xml.getAllSubtrees('local/courseWorkWrapper')>
<#assign local = xml.getAllSubtrees('local')>
<#assign copyright = xml.getAllSubtrees('local/creativeCommons')>

<#list courseWork as courseWork>
    <#assign groupProject = courseWork.get('groupProject')>
    <#assign groupMembers = courseWork.get('groupMembers')>
    <#assign courseWorkType = courseWork.get('courseWorkType')>
    <#-- <dd>${groupProject} -->
    <#-- <dd>${courseWorkType} -->
    <#assign groupProjectUrl = "https://vault.cca.edu/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseWorkWrapper%3E%3CgroupProject%3E${groupProject}%3C%2FgroupProject%3E%3C%2FcourseWorkWrapper%3E%3Cdepartment%3EGraphic+Design%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />
    <#assign courseWorkTypeUrl = "https://vault.cca.edu/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3E${courseWorkType}%3C%2FcourseWorkType%3E%3C%2FcourseWorkWrapper%3E%3Cdepartment%3EGraphic+Design%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />
    <#if courseWorkType=="Course work">

    <dl>
        <#list titleInfo as titleInfo>
            <#assign title = titleInfo.get('title')>
            <#assign subTitle = titleInfo.get('subTitle')>
            <h2 id="title">${title}
            </h2>
        </#list>

        <dt class="hide">Collection</dt>
        <#list local as local>
            <#assign division = local.get('division')>
            <#-- <dd>${division} -->
            <#assign department = local.get('department')>
            <#-- <dd>${department} -->
            <#assign divisionUrl = "https://vault.cca.edu/access/searching.do?doc=%3Cxml%2F%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />
            <#assign departmentUrl = "https://vault.cca.edu/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />

            <dd class="collection"><a href="${departmentUrl}">${department}</a> | <a href="${divisionUrl}">${division}</a></dd>
        </#list>

            <div id="images">
            <#list itemAttachments as itemAttachment>
                <#assign thumb = itemAttachment.get('thumbnail')>
                <#assign full = itemAttachment.get('file')>
                <#if full?contains("http://") || full?ends_with(".zip")><#else>
                    <a href="https://vault.cca.edu/file/${itemUuid}/${itemversion}/${full}" target="_blank">
                    <img src="https://vault.cca.edu/file/${itemUuid}/${itemversion}/${thumb}"/></a>
                </#if>
            </#list>
            </div>


        <#list nameInfo as nameInfo>
            <#assign name = nameInfo.get('namePart')>
            <dt>Description</dt>
            <dd>${name}
            <#list nameInfo.getAllSubtrees('subNameWrapper') as subName>
                <#assign major = subName.get('major')>
                <#-- <dd>${major} -->
                <#assign majorUrl = "https://vault.cca.edu/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3Cname%3E%3CsubNameWrapper%3E%3Cmajor%3E${major}%3C%2Fmajor%3E%3C%2FsubNameWrapper%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />
                <#if (major=="")><#else>
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
            <#assign courseCategory = courseInfo.get('courseCategory')>
            <#assign specialPrograms = courseInfo.get('specialPrograms')>
            <#assign courseName = courseInfo.get('courseName')>
            <#assign XList = courseInfo.get('XList')>
            <#-- <dd>${course} -->
            <#-- <dd>${semester} -->
            <#-- <dd>${faculty} -->
            <#-- <dd>${section} -->
            <#-- <dd>${courseCategory} -->
            <#-- <dd>${specialPrograms} -->
            <#-- <dd>${courseName} -->
            <#assign semesterUrl = "https://vault.cca.edu/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Csemester%3E${semester}%3C%2Fsemester%3E%3C%2FcourseInfo%3E%3Cdepartment%3EGraphic+Design%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />
            <#assign courseUrl = "https://vault.cca.edu/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Ccourse%3E${course}%3C%2Fcourse%3E%3C%2FcourseInfo%3E%3Cdepartment%3EGraphic+Design%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />
            <#assign facultyUrl = "https://vault.cca.edu/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Cfaculty%3E${faculty}%3C%2Ffaculty%3E%3C%2FcourseInfo%3E%3Cdepartment%3EGraphic+Design%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />
            <#assign sectionUrl = "https://vault.cca.edu/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Csection%3E${section}%3C%2Fsection%3E%3C%2FcourseInfo%3E%3Cdepartment%3EGraphic+Design%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />
            <#assign courseCategoryUrl = "https://vault.cca.edu/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3CcourseCategory%3E${courseCategory}%3C%2FcourseCategory%3E%3CspecialPrograms%3E${specialPrograms}%3C%2FspecialPrograms%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />
            <#assign courseNameUrl = "https://vault.cca.edu/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3CcourseName%3E${courseName}%3C%2FcourseName%3E%3C%2FcourseInfo%3E%3Cdepartment%3EGraphic+Design%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />
            <#assign XListUrl = "https://vault.cca.edu/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3CXList%3E${XList}%3C%2FXList%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />

            <#if (semester=="")><i>no course selected</i><#else>
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
                <#else></#if>
            </span>
            <span id="coursestuff" style="font-size: 11.5px;">
                Course number / category: <a href="${courseNameUrl}">${courseName}</a>
                <#if (courseCategory=="")>
                <#elseif (courseCategory!="")>
                     — <a href="${courseCategoryUrl}">${courseCategory}</a>
                </#if>
            </span>
        </#list>

        <dd><a href="${courseWorkTypeUrl}">${courseWorkType}</a>

        <#list physdesc as physdesc>
            <#assign formBroad = physdesc.get('formBroad')>
            <#assign formSpecific = physdesc.get('formSpecific')>
            <#-- <dd>${formBroad} -->
            <#-- <dd>${formSpecific} -->
            <#assign formBroadUrl = "https://vault.cca.edu/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3ECourse+work%3C%2FcourseWorkType%3E%3C%2FcourseWorkWrapper%3E%3Cdepartment%3EGraphic+Design%3C%2Fdepartment%3E%3C%2Flocal%3E%3Cmods%3E%3CphysicalDescription%3E%3CformBroad%3E${formBroad}%3C%2FformBroad%3E%3C%2FphysicalDescription%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />
            <#assign formSpecificUrl = "https://vault.cca.edu/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3ECourse+work%3C%2FcourseWorkType%3E%3C%2FcourseWorkWrapper%3E%3Cdepartment%3EGraphic+Design%3C%2Fdepartment%3E%3C%2Flocal%3E%3Cmods%3E%3CphysicalDescription%3E%3CformBroad%3E2D%3C%2FformBroad%3E%3CformSpecific%3E${formSpecific}%3C%2FformSpecific%3E%3C%2FphysicalDescription%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />
             — <a href="${formBroadUrl}">${formBroad}</a>
             — <a href="${formSpecificUrl}">${formSpecific}</a>
        </#list>
            </dd>

        <#list itemAttachments as itemAttachment>
            <#assign type = itemAttachment.get('@type')>
            <#assign full = itemAttachment.get('file')>
            <dd><#if type=="remote">
                Related link: <a href="${full}" target="_blank">${full}</a>
            <#else></#if>
            </dd>
        </#list>

        <dd>
        <#if groupProject=="individual project">
            This was an <a href="${groupProjectUrl}">${groupProject}</a>.
        <#elseif groupProject=="group project">
            This was a <a href="${groupProjectUrl}">${groupProject}</a>
        </#if>
        <#if groupMembers==""><#else>
            with ${groupMembers}.
        </#if>
        </dd>

        <#list copyright as copyright>
            <#assign type = copyright.get('type')>
            <#-- <dd>${type} -->
            <#assign typeUrl = "https://vault.cca.edu/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3Cdepartment%3EGraphic+Design%3C%2Fdepartment%3E%3CcreativeCommons%3E%3Ctype%3E${type}%3C%2Ftype%3E%3C%2FcreativeCommons%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />

            <dd>Copyright authorization: <a href="${typeUrl}">${type}</a></dd>
        </#list>

<#else></#if>
</#list>
