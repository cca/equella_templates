<#function escapeAmp str>
    <#-- returns a URI-encoded "&amp;"
    because we are passing XML in the URI, we have to escape this way -->
    <#return str?replace('&', '%26amp%3B')>
</#function>

<#assign titleInfo = xml.getAllSubtrees('mods/titleInfo')>
<#assign itemAttachments = xml.getAllSubtrees('item/attachments/attachment')>
<#assign name = xml.getAllSubtrees('mods/name')>
<#assign subNameWrapper = xml.getAllSubtrees('mods/name/subNameWrapper')>
<#assign modslevel = xml.getAllSubtrees('mods')>
<#assign courseInfo = xml.getAllSubtrees('local/courseInfo')>
<#assign courseWork = xml.getAllSubtrees('local/courseWorkWrapper')>
<#assign local = xml.getAllSubtrees('local')>

<style scoped>
/* disable links that point nowhere */
a[href=""] {
  color: #4b4842; /* default text color */
  pointer-events: none;
}
</style>

<dl>
<#list courseWork as courseWork>
<#assign courseWorkType = courseWork.get('courseWorkType')>
<#assign finalFile = courseWork.get('file')>
<#if courseWorkType == "Course work">

    <#list titleInfo as titleInfo>
        <#assign title = titleInfo.get('title')>
        <#assign subTitle = titleInfo.get('subTitle')>
        <h2 id="title">${title}</h2>
</dl>
    </#list>

    <dt class="hide">Collection</dt>
    <#list local as local>
        <#assign division = local.get('division')>
        <#assign department = local.get('department')>
        <#assign divisionUrl = "/access/searching.do?doc=%3Cxml%2F%3E&in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&q=&sort=datemodified&dr=AFTER" />
        <#assign departmentUrl = "/access/searching.do?in=C66558697-71c5-43a0-b7b3-f778b42c7cd9&q=&sort=datemodified&dr=AFTER" />
        <dd class="collection">
            <a href="${departmentUrl}">${department}</a> | <a href="${divisionUrl}">${division}</a>
        </dd>
    </#list>

    <dt>Description</dt>
    <#assign name = xml.getAllSubtrees('mods/name')>
    <#list name as name>
        <#assign namePart = name.get('namePart')>
        <dd>
            <#if namePart != "">
                ${namePart}
            </#if>
            <#list name.getAllSubtrees('subNameWrapper') as subName>
                <#assign major = subName.get('major')>
                <#assign majorUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3Cname%3E%3CsubNameWrapper%3E%3Cmajor%3E${major}%3C%2Fmajor%3E%3C%2FsubNameWrapper%3E%3C%2Fname%3E%3C%2Flocal%3E%3Cmods%3E%3Cname%3E%3CsubNameWrapper%3E%3Cmajor%3E${major}%3C%2Fmajor%3E%3C%2FsubNameWrapper%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&q=&sort=datemodified&dr=AFTER" />
                <#if major != "">
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
        <#assign specialPrograms = courseInfo.get('specialPrograms')>
        <#assign semesterUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Csemester%3E${semester}%3C%2Fsemester%3E%3C%2FcourseInfo%3E%3Cdepartment%3EAnimation%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&sort=datemodified&dr=AFTER" />
        <#assign courseUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Ccourse%3E${escapeAmp(course)}%3C%2Fcourse%3E%3C%2FcourseInfo%3E%3Cdepartment%3EAnimation%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&q=&sort=datemodified&dr=AFTER" />
        <#assign facultyUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Cfaculty%3E${faculty}%3C%2Ffaculty%3E%3C%2FcourseInfo%3E%3Cdepartment%3EAnimation%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&q=&sort=datemodified&dr=AFTER" />
        <#assign sectionUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Csection%3E${section}%3C%2Fsection%3E%3C%2FcourseInfo%3E%3Cdepartment%3EAnimation%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&q=&sort=datemodified&dr=AFTER" />
        <#-- note: this URL isn't used below -->
        <#assign courseCategoryUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3CcourseCategory%3E${courseCategory}%3C%2FcourseCategory%3E%3C%2FcourseInfo%3E%3Cdepartment%3EAnimation%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&q=&sort=datemodified&dr=AFTER" />
        <dd>
            <#if semester != "">
                <a href="${semesterUrl}">${semester}</a>
            </#if>
            <#if semester != "" && course != ""> - </#if>
            <#if course != "">
                <a href="${courseUrl}">${course}</a> —
            </#if>
            <#if faculty!= "">
                <a href="${facultyUrl}">${faculty}</a> —
            </#if>
            <#if section!= "">
                <a href="${sectionUrl}">${section}</a>
            </#if>
        </dd>
        <#-- couldn't find this field in the Wizard
        nor in any actual item -->
        <#if courseCategory != "">
            <dd>Course category: ${courseCategory}</dd>
        </#if>
    </#list>

    <#assign selfEval = courseWork.get('process')>
    <#assign workType = courseWork.get('workType')>
    <#assign assignTopic = courseWork.get('courseWorkTypeSpecific')>
    <#assign imageType = courseWork.get('imageType')>
    <#assign groupProject = courseWork.get('groupProject')>
    <#assign groupMembers = courseWork.get('groupProjectNumber')>
    <#assign groupProjectUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseWorkWrapper%3E%3CgroupProject%3E${groupProject}%3C%2FgroupProject%3E%3C%2FcourseWorkWrapper%3E%3Cdepartment%3EAnimation%3C%2Fdepartment%3E%3C%2Flocal%3E%3Cmods%3E%3Cname%3E%3CnamePart%2F%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&q=&sort=datemodified&dr=AFTER" />
    <#-- hard-coding both dept & courseWorkType into courseWorkTypeUrl
    since this is already an Animation > Course Work template -->
    <#assign courseWorkTypeUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3ECourse+work%3C%2FcourseWorkType%3E%3C%2FcourseWorkWrapper%3E%3Cdepartment%3EAnimation%3C%2Fdepartment%3E%3C%2Flocal%3E%3Cmods%3E%3Cname%3E%3CnamePart%2F%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&q=&sort=datemodified&dr=AFTER" />
    <#assign workTypeUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseWorkWrapper%3E%3CworkType%3E${workType}%3C%2FworkType%3E%3C%2FcourseWorkWrapper%3E%3Cdepartment%3EAnimation%3C%2Fdepartment%3E%3C%2Flocal%3E%3Cmods%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&q=&sort=datemodified&dr=AFTER" />
    <#assign imageTypeUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3Cdepartment%3EAnimation%3C%2Fdepartment%3E%3CcourseWorkWrapper%3E%3CimageType%3E${imageType}%3C%2FimageType%3E%3C%2FcourseWorkWrapper%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&q=&sort=datemodified&dr=AFTER" />
    <dd>
        <#if courseWorkType != "">
            <a href="${courseWorkTypeUrl}">${courseWorkType}</a>
        </#if>
        <#if workType != "">
             — <a href="${workTypeUrl}">${workType}</a>
        </#if>
        <#if imageType != "">
             — <a href="${imageTypeUrl}">${imageType}</a>
        </#if>
        <#-- weird conflict if a new Power Search control is added
        2 things (Type of admin doc is other) target courseWorkTypeSpecific
        searches will fill in *both* controls at once -->
        <#if assignTopic != "">
            <#assign assignTopicUrl = "" />
             — ${assignTopic}
        </#if>
    </dd>
        <#if selfEval != "">
            <dd>Self evaluation: ${selfEval}</dd>
        </#if>
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

    <dt>File list</dt>
    <#list xml.getAllSubtrees('local/courseWorkWrapper/file') as finalFile>
        <#list itemAttachments as itemAttachment>
            <#if finalFile.get('/') = itemAttachment.get('uuid')>
                <#assign full = itemAttachment.get('file')>
                <#assign uuid = itemAttachment.get('uuid')>
                <dd><strong>Final project file</strong>: <i>${full}</i></dd>
            </#if>
        </#list>
    </#list>

    <#list xml.getAllSubtrees('mods/part/number') as files>
        <#list itemAttachments as itemAttachment>
            <#if files.get('/') = itemAttachment.get('uuid')>
                <#assign full = itemAttachment.get('file')>
                <#assign uuid = itemAttachment.get('uuid')>
                <dd>
                    <#if workType=='final project'>
                        <strong>Pre-production file</strong>:
                    <#elseif workType=='not a final project'>
                        <strong>Project file (not final project)</strong>:
                    </#if>
                    <i>${full}</i>
                </dd>
            </#if>
        </#list>
    </#list>

</#if>
</#list>
