<#function escapeAmp str>
    <#-- returns a URI-encoded "&amp;"
    because we pass XML in the URI, we have to escape this way -->
    <#return str?replace('&', '%26amp%3B')>
</#function>

<#assign itemUuid = xml.get('item/@id')>
<#assign itemversion = xml.get('item/@version')>
<#assign titleInfo = xml.getAllSubtrees('mods/titleInfo')>
<#assign itemAttachments = xml.getAllSubtrees('item/attachments/attachment')>
<#assign name = xml.getAllSubtrees('mods/name')>
<#assign subNameWrapper = xml.getAllSubtrees('mods/name/subNameWrapper')>
<#assign physdesc = xml.getAllSubtrees('mods/physicalDescription')>
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
<#if (courseWorkType =="Course work")>

    <#list titleInfo as titleInfo>
        <#assign title = titleInfo.get('title')>
        <#assign subTitle = titleInfo.get('subTitle')>
        <h2 id="title">${title}
        </h2>
    </#list>

    <dt class="hide">Collection</dt>
    <#list local as local>
        <#assign division = local.get('division')>
        <#assign divisionUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3Cdivision%3E${division}%3C%2Fdivision%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pb0cd301e-6adf-48c5-59aa-9a7a2e7f9834&q=&sort=rank&dr=AFTER" />
        <dd class="collection"><a href="${divisionUrl}">${division}</a></dd>
    </#list>

        <div id="images">
            <#list itemAttachments as itemAttachment>
                <#assign thumb = itemAttachment.get('thumbnail')>
                <#assign full = itemAttachment.get('file')>
                <#assign uuid = itemAttachment.get('uuid')>
                <#if (full?contains("http://") || full?ends_with(".zip"))><#else>
                    <a href="/file/${itemUuid}/${itemversion}/${full}">
                        <img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/>
                    </a>
                </#if>
            </#list>
        </div>

    <#assign name = xml.getAllSubtrees('mods/name')>
    <#list name as name>
        <#assign namePart = name.get('namePart')>
        <#if name_index==0 && (namePart !="")>
            <dt>Creator</dt>
        </#if>
        <#if namePart != "">
            <dd>${namePart}
        </#if>
        <#list name.getAllSubtrees('subNameWrapper') as subName>
            <#assign major = subName.get('major')>
            <#assign majorUrl = "/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3Cname%3E%3CsubNameWrapper%3E%3Cmajor%3E${major}%3C%2Fmajor%3E%3C%2FsubNameWrapper%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />
            <#if major != "">
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
        <#assign courseUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Ccourse%3E${escapeAmp(course)}%3C%2Fcourse%3E%3C%2FcourseInfo%3E%3Cdepartment%3EFashion+Design%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />
        <#assign semesterUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3CcourseInfo%3E%24%7Bcourse%7D%3C%2FcourseInfo%3E%3Csemester%3E${semester}%3C%2Fsemester%3E%3C%2FcourseInfo%3E%3Cdepartment%3EFashion+Design%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&sort=datemodified&dr=AFTER" />
        <#assign facultyUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Cfaculty%3E${faculty}%3C%2Ffaculty%3E%3C%2FcourseInfo%3E%3Cdepartment%3EFashion+Design%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />
        <#assign sectionUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Csection%3E${section}%3C%2Fsection%3E%3C%2FcourseInfo%3E%3Cdepartment%3EFashion+Design%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />
        <#-- @todo fix these URLs -->
        <#assign courseCategoryUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3CcourseCategory%3E${courseCategory}%3C%2FcourseCategory%3E%3C%2FcourseInfo%3E%3Cdepartment%3EFashion+Design%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />
        <#assign courseNameUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3CcourseName%3E${courseName}%3C%2FcourseName%3E%3C%2FcourseInfo%3E%3Cdepartment%3EFashion+Design%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />
        <#assign specialProgramsUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3CspecialPrograms%3E${specialPrograms}%3C%2FspecialPrograms%3E%3C%2FcourseInfo%3E%3Cdepartment%3EFashion+Design%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />

        <dt>Course Info</dt>
        <#if semester ==""><i>no course selected</i><#else>
        <span id="coursestuff">
            <a href="${semesterUrl}">${semester}</a>
            — <a href="${courseUrl}">${course}</a>
            — <a href="${facultyUrl}">${faculty}</a>
            — <a href="${sectionUrl}">${section}</a>
        </span>
        </#if>
        <#if XList != "">
            <span id="coursestuff">Section cross-listed with ${XList}.</span>
        <#elseif (XList != "") && (courseCategory != "")>
        <span id="coursestuff">Section cross-listed with ${XList}.
        Course category: <a href="${courseCategoryUrl}">${courseCategory}</a>
            <#if (specialPrograms!="")>, <a href="${specialProgramsUrl}">${specialPrograms}</a>
            </#if>
        </span>
        <#elseif (XList=="") && (courseCategory!="")>
        <span id="coursestuff">Course category: <a href="${courseCategoryUrl}">${courseCategory}</a>
            <#if (specialPrograms!="")>, <a href="${specialProgramsUrl}">${specialPrograms}</a>
            </#if>
        </span>
        <#elseif (XList=="") && (courseCategory=="") && (specialPrograms!="")>
        <span id="coursestuff">
            Course category:  <a href="${specialProgramsUrl}">${specialPrograms}</a>
        </span>
        </#if>
    </#list>

        <#assign workType = courseWork.get('workType')>
        <#assign courseWorkTypeSpecific = courseWork.get('courseWorkTypeSpecific')>
        <#assign groupProject = courseWork.get('groupProject')>
        <#assign groupMembers = courseWork.get('groupMembers')>
        <#assign groupContribution = courseWork.get('groupContribution')>
        <#-- @todo fix these URLs -->
        <#assign groupProjectUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseWorkWrapper%3E%3CgroupProject%3E${groupProject}%3C%2FgroupProject%3E%3C%2FcourseWorkWrapper%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&sort=datemodified&dr=AFTER" />
        <#assign courseWorkTypeUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3E${courseWorkType}%3C%2FcourseWorkType%3E%3C%2FcourseWorkWrapper%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />
        <#assign workTypeUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseWorkWrapper%3E%3CworkType%3E${workType}%3C%2FworkType%3E%3C%2FcourseWorkWrapper%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&sort=datemodified&dr=AFTER" />
        <dt>Description</dt>
        <#-- @todo better "—" handling throughout
        ex: /items/bc1fe105-daca-482b-b3b9-ec52cdfac440/1/ -->
        <dd>
        <#if courseWorkType == "">{undefined submission type}<#else>
            <a href="${courseWorkTypeUrl}">${courseWorkType}</a>
        </#if>
        <#if workType != "">
             — <a href="${workTypeUrl}">${workType}</a>
            <#else>
        </#if>

        <#list physdesc as physdesc>
            <#assign formBroads = physdesc.list('formBroad')>
            <#assign formSpecifics = physdesc.list('formSpecific')>
            <#-- @todo fix these URLs -->
            <#if (formBroads?size > 0)>
                 — <#list formBroads as formBroad>
                    <#assign formBroadUrl = "" />
                    <a href="${formBroadUrl}">${formBroad}</a><#if formBroad_has_next>, </#if>
                </#list>
            </#if>
            <#if (formSpecifics?size > 0)>
                 — <#list formSpecifics as formSpecific>
                    <#assign formSpecificUrl = "" />
                    <a href="${formSpecificUrl}">${formSpecific}</a><#if formSpecific_has_next>, </#if>
                </#list>
            </#if>
        </#list>
        </dd>

        <#if courseWorkTypeSpecific == "other">
        <#elseif courseWorkTypeSpecific != "">
            <#assign courseWorkTypeSpecificUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3E${courseWorkType}%3C%2FcourseWorkType%3E%3CcourseWorkTypeSpecific%3E${courseWorkTypeSpecific}%3C%2FcourseWorkTypeSpecific%3E%3C%2FcourseWorkWrapper%3E%3Cdepartment%3EFashion+Design%3C%2Fdepartment%3E%3Ctags%2F%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />
             <dd>Product category: <a href="${courseWorkTypeSpecificUrl}">${courseWorkTypeSpecific}</a></dd>
            <#else>
        </#if>

        <#assign otherWear = xml.getAllSubtrees('local/courseWorkWrapper/process')>
        <#assign otherWearx = courseWork.get('process')>
        <#-- @todo fix this URL
        ex: /items/e5311436-b1ad-4e74-871b-ce636061319c/1/ -->
        <#assign otherWearUrl = "" />
        <#if otherWearx != "">
             <dd>Product category:
             <#list otherWear as otherWear>
                <a href="${otherWearUrl}">${otherWear}</a><#if otherWear_has_next>, </#if>
            </#list>
            </dd>
        </#if>

        <#list local as local>
            <#assign tags = local.list('tags')>
            <#assign objective = local.get('objective')>
            <#-- @todo find item with objective to test here -->
            <#assign objectiveUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3Cdepartment%3EFashion+Design%3C%2Fdepartment%3E%3Cobjective%3E${objective}%3C%2Fobjective%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />
            <#if (tags?size > 0)>
                <dd>Additional tags:
                <#-- @todo fix this URL
                ex: https://vault.cca.edu/items/9db1a174-2a18-41f4-826e-296d43864b16/1/ -->
                <#if (objective != "" && tags?size > 0)><a href="${objectiveUrl}">${objective}</a>,
                <#elseif objective != ""><a href="${objectiveUrl}">${objective}</a>
                </#if>
                <#list tags as tag>
                    <#assign tagUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3Cdepartment%3EFashion+Design%3C%2Fdepartment%3E%3Ctags%3E${tag}%3C%2Ftags%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />
                     <a href="${tagUrl}">${tag}</a><#if tag_has_next>, </#if>
                </#list>
            </#if>
            </dd>
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

    <#list modslevel as mods>
        <#assign abstract = mods.get('abstract')>
        <#if (abstract != "")>
            <dd>${abstract}</dd></#if>
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
    <#if groupContribution==""><#else>
        <dd>My contribution: ${groupContribution}</dd>
    </#if>

</#if>
</#list>
