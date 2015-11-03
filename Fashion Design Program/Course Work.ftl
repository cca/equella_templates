<#function escapeAmp str>
    <#-- returns a URI-encoded "&amp;"
    because we pass XML in the URI, we have to escape this way -->
    <#return str?replace('&', '%26amp%3B')>
</#function>

<#assign itemUuid = xml.get('item/@id')>
<#assign itemversion = xml.get('item/@version')>
<#assign itemAttachments = xml.getAllSubtrees('item/attachments/attachment')>
<#assign courseInfo = xml.getAllSubtrees('local/courseInfo')>

<#list xml.getAllSubtrees('local/courseWorkWrapper') as courseWork>
<#assign courseWorkType = courseWork.get('courseWorkType')>
<#if (courseWorkType == "Course work")>
<dl>
    <#assign title = xml.get('mods/titleInfo/title')>
    <#assign subTitle = xml.get('mods/titleInfo/subTitle')>
    <h2 id="title">${title} <#if subTitle != "">${subTitle}</#if></h2>

    <dt class="hide">Collection</dt>
    <#assign division = xml.get('local/division')>
    <#assign divisionUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3Cdivision%3E${division}%3C%2Fdivision%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pb0cd301e-6adf-48c5-59aa-9a7a2e7f9834&q=&sort=rank&dr=AFTER" />
    <dd class="collection"><a href="${divisionUrl}">${division}</a></dd>

    <div id="images">
    <#list itemAttachments as itemAttachment>
        <#assign full = itemAttachment.get('file')>
        <#if ! full?contains("http://") && ! full?ends_with(".zip")>
            <#assign uuid = itemAttachment.get('uuid')>
            <a href="/file/${itemUuid}/${itemversion}/${full}">
                <img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/>
            </a>
        </#if>
    </#list>
    </div>

    <#list xml.getAllSubtrees('mods/name') as name>
        <#assign namePart = name.get('namePart')>
        <#if name_index == 0 && (namePart != "")>
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
        </#list></dd>
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
        <#if semester == ""><i>no course selected</i><#else>
        <#-- @todo shouldn't have multiple elements with same ID
        convert #coursestuff to a class, but has implications for
        all collections & the theme -->
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
            <#if (specialPrograms != "")>, <a href="${specialProgramsUrl}">${specialPrograms}</a>
            </#if>
        </span>
        <#elseif (XList == "") && (courseCategory != "")>
        <span id="coursestuff">Course category: <a href="${courseCategoryUrl}">${courseCategory}</a>
            <#if (specialPrograms != "")>, <a href="${specialProgramsUrl}">${specialPrograms}</a>
            </#if>
        </span>
        <#elseif (XList == "") && (courseCategory == "") && (specialPrograms != "")>
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
    <dd>
    <#if courseWorkType == "">{undefined submission type}<#else>
        <a href="${courseWorkTypeUrl}">${courseWorkType}</a>
    </#if>
    <#if workType != "">
         — <a href="${workTypeUrl}">${workType}</a>
    </#if>

    <#assign formBroads = xml.list('mods/physicalDescription/formBroad')>
    <#assign formSpecifics = xml.list('mods/physicalDescription/formSpecific')>
    <#-- @todo fix these URLs -->
    <#if (formBroads?size > 0)>
         — <#list formBroads as formBroad>
            <#assign formBroadUrl = "" />
            <a href="${formBroadUrl}">${formBroad}</a><#if formBroad_has_next>, </#if>
        </#list>
    </#if>
    <#if (formSpecifics?size != 0)>
         — <#list formSpecifics as formSpecific>
            <#assign formSpecificUrl = "" />
            <a href="${formSpecificUrl}">${formSpecific}</a><#if formSpecific_has_next>, </#if>
        </#list>
    </#if>
    </dd>

    <#if courseWorkTypeSpecific != "other" && courseWorkTypeSpecific != "">
        <#assign courseWorkTypeSpecificUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3E${courseWorkType}%3C%2FcourseWorkType%3E%3CcourseWorkTypeSpecific%3E${courseWorkTypeSpecific}%3C%2FcourseWorkTypeSpecific%3E%3C%2FcourseWorkWrapper%3E%3Cdepartment%3EFashion+Design%3C%2Fdepartment%3E%3Ctags%2F%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />
         <dd>Product category: <a href="${courseWorkTypeSpecificUrl}">${courseWorkTypeSpecific}</a></dd>
    </#if>

    <#assign otherWears = courseWork.list('process')>
    <#if otherWears?size != 0>
         <dd>Product category:
         <#list otherWears as otherWear>
            <#-- @todo fix this URL
            ex: /items/e5311436-b1ad-4e74-871b-ce636061319c/1/ -->
            <#assign otherWearUrl = "" />
            <a href="${otherWearUrl}">${otherWear}</a><#if otherWear_has_next>, </#if>
        </#list>
        </dd>
    </#if>

    <#assign tags = xml.list('local/tags')>
    <#if (tags?size != 0)>
        <dd>Additional tags:
        <#list tags as tag>
            <#assign tagUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3Cdepartment%3EFashion+Design%3C%2Fdepartment%3E%3Ctags%3E${tag}%3C%2Ftags%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />
             <a href="${tagUrl}">${tag}</a><#if tag_has_next>, </#if>
        </#list>
    </#if>
    </dd>

    <#assign sustainabilityDetails = xml.get('local/courseWorkWrapper/assignmentDescription')>
    <#if sustainabilityDetails != "">
        <#assign sustainabilityUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3Cdepartment%3EFashion+Design%3C%2Fdepartment%3E%3Cobjective%3Esustainability%3C%2Fobjective%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER">
        <dd><a href="${sustainabilityUrl}">Sustainability</a> Details: ${sustainabilityDetails}</dd>
    </#if>

    <#list itemAttachments as itemAttachment>
        <#assign type = itemAttachment.get('@type')>
        <dd>
        <#if type == "remote">
            <#assign full = itemAttachment.get('file')>
            Related link: <a href="${full}">${full}</a>
        </#if>
        </dd>
    </#list>

    <#assign abstract = xml.get('mods/abstract')>
    <#if (abstract != "")><dd>${abstract}</dd></#if>

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
    <#if groupContribution != "">
        <dd>My contribution: ${groupContribution}</dd>
    </#if>

</#if>
</#list>
