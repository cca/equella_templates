<#function escapeAmp str>
    <#-- returns a URI-encoded "&amp;"
    because we are passing XML in the URI, we have to escape this way -->
    <#return str?replace('&', '%26amp%3B')>
</#function>

<#assign itemUuid = xml.get('item/@id')>
<#assign itemVersion = xml.get('item/@version')>
<#assign itemAttachments = xml.getAllSubtrees('item/attachments/attachment')>
<#assign subNameWrapper = xml.getAllSubtrees('mods/name/subNameWrapper')>
<#assign courseInfo = xml.getAllSubtrees('local/courseInfo')>

<#list xml.getAllSubtrees('local/courseWorkWrapper') as courseWork>
<#assign courseWorkType = courseWork.get('courseWorkType')>
<#if courseWorkType == "Senior review">
<dl>
    <#assign title = xml.get('mods/titleInfo/title')>
    <h2 id="title">${title}</h2>

    <dt class="hide">Collection</dt>
    <#list xml.getAllSubtrees('local') as local>
        <#assign division = local.get('division')>
        <#assign department = local.get('department')>
        <#assign divisionUrl = "/access/searching.do?doc=%3Cxml%2F%3E&in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&q=&sort=datemodified&dr=AFTER" />
        <#assign departmentUrl = "/access/searching.do?in=C66558697-71c5-43a0-b7b3-f778b42c7cd9&q=&sort=datemodified&dr=AFTER" />
        <dd class="collection"><a href="${departmentUrl}">${department}</a> | <a href="${divisionUrl}">${division}</a></dd>
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
        <#-- @todo can I find an item that confirms this link works? -->
        <#assign courseCategoryUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3CcourseCategory%3E${courseCategory}%3C%2FcourseCategory%3E%3C%2FcourseInfo%3E%3Cdepartment%3EAnimation%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&q=&sort=datemodified&dr=AFTER" />
        <dd>
        <#if semester != "">
            <a href="${semesterUrl}">${semester}</a>
        </#if>
        <#if course != "" && course != "undefined">
             — <a href="${courseUrl}">${course}</a>
        </#if>
        <#if faculty != "" && faculty != "undefined">
             — <a href="${facultyUrl}">${faculty}</a>
        </#if>
        <#if section != "" && section != "undefined">
             — <a href="${sectionUrl}">${section}</a>
        </#if>
        </dd>
        <#if courseCategory != "">
            <dd>Course category: <a href="${courseCategoryUrl}">${courseCategory}</a></dd>
        </#if>
    </#list>

    <#assign selfEval = courseWork.get('process')>
    <#assign workType = courseWork.get('workType')>
    <#assign assignTopic = courseWork.get('courseWorkTypeSpecific')>
    <#assign imageType = courseWork.get('imageType')>
    <#assign groupProject = courseWork.get('groupProject')>
    <#assign groupMembers = courseWork.get('groupProjectNumber')>
    <#assign groupProjectUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseWorkWrapper%3E%3CgroupProject%3E${groupProject}%3C%2FgroupProject%3E%3C%2FcourseWorkWrapper%3E%3Cdepartment%3EAnimation%3C%2Fdepartment%3E%3C%2Flocal%3E%3Cmods%3E%3Cname%3E%3CnamePart%2F%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&q=&sort=datemodified&dr=AFTER" />
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
    <#-- not using URL due to conflict
    described in Animation > Course Work.ftl -->
    <#if assignTopic != "">
        <#assign assignTopicUrl = "" />
         — ${assignTopic}
    </#if>
    </dd>
    <#if selfEval != "">
        <dd>Self evaluation: ${selfEval}</dd>
    </#if>

    <dt>File list</dt>

    <#assign artistDoc = xml.get('/local/artistDocWrapper/artistStatementFile')>
    <#if artistDoc != "">
    <dt>Artist Statement</dt>
        <#list itemAttachments as itemAttachment>
            <#if artistDoc == itemAttachment.get('uuid')>
                <#assign full = itemAttachment.get('file')>
                <#assign uuid = itemAttachment.get('uuid')>
                <div class="image-photoSeniorPacket">
                <dd><strong>Artist's Statement</strong></dd>
                <p><a href="/items/${itemUuid}/${itemVersion}/${full}"><img src="/thumbs/${itemUuid}/${itemVersion}/${uuid}"></a></p>
                </div>
            </#if>
        </#list>
    </#if>

    <#list xml.getAllSubtrees('/local/juniorReviewWrapper/fileWrapper') as file>
        <#list itemAttachments as itemAttachment>
            <#if file.get('file') == itemAttachment.get('uuid')>
                <#assign full = itemAttachment.get('file')>
                <#assign uuid = itemAttachment.get('uuid')>
                <#assign title = file.get('title')>
                <#assign format = file.get('projectFormat')>
                <#assign projectFormat = file.get('projectFormatWrapper/projectFormat')>
                <#assign duration = file.get('extent')>
                <#assign keywords = file.getAllSubtrees('keyWordWrapper')>
                <div class="image-photoSeniorPacket">
                    <dd><strong>${format}</strong>:</dd>
                    <a href="/items/${itemUuid}/${itemVersion}/${full}" rel="group"><img src="/thumbs/${itemUuid}/${itemVersion}/${uuid}"></a></p>
                    <p class="photoImagelist">
                        <#if title != "">${title}<br></#if>
                        <#if projectFormat != "">${projectFormat}</#if>
                        <#if duration != ""> - ${duration}</#if>
                        <#list keywords as keyword>
                            ${keyword}<#if keyword_has_next>, </#if>
                        </#list>
                    </p>
                </div>
            </#if>
        </#list>
    </#list>
</dl>
</#if>
</#list>
<script>
$(function(){
    // little tricky here, but we're filtering to _only_ jpg/png images
    $('.image-photoSeniorPacket a').filter(function(){
        return this.href.match(/(\.(jpe?g|png)?)$/i)
    }).attr('href', (i, href) => href + '?.vi=fancy').fancybox()
})
</script>
