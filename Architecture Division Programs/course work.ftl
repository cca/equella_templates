<#assign itemUuid = xml.get('item/@id')>
<#assign itemversion = xml.get('item/@version')>
<#assign titleInfo = xml.getAllSubtrees('mods/titleInfo')>
<#assign itemAttachments = xml.getAllSubtrees('item/attachments/attachment')>
<#assign name = xml.getAllSubtrees('mods/name')>
<#assign physdesc = xml.getAllSubtrees('mods/physicalDescription')>
<#assign modslevel = xml.getAllSubtrees('mods')>
<#assign courseInfo = xml.getAllSubtrees('local/courseInfo')>
<#assign courseWork = xml.getAllSubtrees('local/courseWorkWrapper')>
<#assign local = xml.getAllSubtrees('local')>
<#assign part = xml.getAllSubtrees('mods/part')>
<#assign tags = xml.getAllSubtrees('local/tagWrapper')>

<dl>
<#assign courseWorkTypeSpecific = xml.getAllSubtrees('local/courseWorkWrapper/courseWorkTypeSpecific')>
<#assign workType = xml.getAllSubtrees('local/courseWorkWrapper/workType')>
<#list courseWork as courseWork>
<#assign submissionType = courseWork.get('submissionType')>
<#if (submissionType == "Course work")>

    <#assign tag = xml.getAllSubtrees('local/tags')>
    <#list local as local>
        <#assign department = local.get('department')>
        <#assign division = local.get('division')>
        <dt class="hide">Division</dt>
        <#assign divisionUrl = "" />
        <#assign departmentUrl = "" />
        <dd class="collection">${department} | ${division}</dd>
    </#list>

    <#list titleInfo as titleInfo>
        <#assign title = titleInfo.get('title')>
        <h2 id="title">${title}
        </h2>
    </#list>

    <#list name as name>
        <#assign namePart = name.get('namePart')>
        <dd><strong>Student</strong>: ${namePart}
        <#list name.getAllSubtrees('subNameWrapper') as subName>
            <#assign major = subName.get('major')>
            <#assign majorUrl = "/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3Cname%3E%3CsubNameWrapper%3E%3Cmajor%3E${major}%3C%2Fmajor%3E%3C%2FsubNameWrapper%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=Pafcc42be-462c-483e-b2ed-98ffcd15ff3d&q=&sort=datemodified&dr=AFTER" />
            <#if major != ""> -
                <a href="${majorUrl}">${major}</a>
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
        <#assign XList = courseInfo.get('XList')>
        <#assign courseUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Ccourse%3E${course}%3C%2Fcourse%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pafcc42be-462c-483e-b2ed-98ffcd15ff3d&q=&sort=datemodified&dr=AFTER" />
        <#assign departmentUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pafcc42be-462c-483e-b2ed-98ffcd15ff3d&q=&sort=datemodified&dr=AFTER" />
        <#assign semesterUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Csemester%3E${semester}%3C%2Fsemester%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pafcc42be-462c-483e-b2ed-98ffcd15ff3d&q=&sort=datemodified&dr=AFTER" />
        <#assign facultyUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Cfaculty%3E${faculty}%3C%2Ffaculty%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pafcc42be-462c-483e-b2ed-98ffcd15ff3d&q=&sort=datemodified&dr=AFTER" />
        <#assign sectionUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Csection%3E${section}%3C%2Fsection%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pafcc42be-462c-483e-b2ed-98ffcd15ff3d&q=&sort=datemodified&dr=AFTER" />

        <#if (semester=="") || (semester=="undefined")><#else>

            <span id="coursestuff"><strong>Course</strong>:
                <a href="${semesterUrl}">${semester}</a>
                 — <a href="${departmentUrl}">${department}</a>
                 — <a href="${courseUrl}">${course}</a>
                 — <a href="${facultyUrl}">${faculty}</a>
                 — <a href="${sectionUrl}">${section}</a>
            </span>
            <span id="coursestuff">
                <#if XList!="">
                    (Cross-listed as ${XList}.)
                </#if>
            </span>
        </#if>
    </#list>

    <#assign courseWorkType = courseWork.get('courseWorkType')>
    <#assign imageType = courseWork.get('imageType')>
    <#assign courseWorkTypeSpecificx = courseWork.get('courseWorkTypeSpecific')>
    <#assign workTypex = courseWork.get('workType')>
    <#assign groupProject = courseWork.get('groupProject')>
    <#assign groupProjectNumber = courseWork.get('groupProjectNumber')>
    <#assign groupConstituents = courseWork.get('groupConstituents')>
    <#assign process = courseWork.get('process')>
    <#assign projectTitle = courseWork.get('projectTitle')>
    <#assign courseWorkTypeUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3E${courseWorkType}%3C%2FcourseWorkType%3E%3C%2FcourseWorkWrapper%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pafcc42be-462c-483e-b2ed-98ffcd15ff3d&q=&sort=datemodified&dr=AFTER" />
    <#assign imageTypeUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseWorkWrapper%3E%3CimageType%3E${imageType}%3C%2FimageType%3E%3C%2FcourseWorkWrapper%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pafcc42be-462c-483e-b2ed-98ffcd15ff3d&q=&sort=datemodified&dr=AFTER" />
    <#assign groupProjectUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseWorkWrapper%3E%3CgroupProject%3E${groupProject}%3C%2FgroupProject%3E%3C%2FcourseWorkWrapper%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pafcc42be-462c-483e-b2ed-98ffcd15ff3d&q=&sort=datemodified&dr=AFTER" />
    <#assign groupConstituentsUrl = "" />
    <#assign courseWorkTypeSpecificUrl = "" />

    <dd><strong>Description</strong>:
    <#if courseWorkType != "">
        ${courseWorkType}
    </#if>
    <#if (courseWorkType!="")&&(projectTitle!="")> | </#if>
    <#if projectTitle != "">
        Project Number ${projectTitle}
    </#if>
    <#if workTypex != ""> —
        <#list workType as workType>
            <#assign workTypeUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseWorkWrapper%3E%3CworkType%3E${workType}%3C%2FworkType%3E%3C%2FcourseWorkWrapper%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pafcc42be-462c-483e-b2ed-98ffcd15ff3d&q=&sort=datemodified&dr=AFTER" />
            ${workType}<#if workType_has_next>, </#if>
        </#list>
    </#if>
    </dd>
    <#if courseWorkTypeSpecificx != "">
        <dd><strong>Submission format</strong>:
            <#list courseWorkTypeSpecific as courseWorkTypeSpecific>
                ${courseWorkTypeSpecific}<#if courseWorkTypeSpecific_has_next> & </#if>
            </#list>
        </dd>
    </#if>
    <#if imageType != "">
        <dd><strong>Image type</strong>: <a href="${imageTypeUrl}">${imageType}</a></dd>
    </#if>

    <#assign formSpecific = xml.getAllSubtrees('mods/physicalDescription/formSpecific')>
    <#list physdesc as physdesc>
        <#assign formSpecificx = physdesc.get('formSpecific')>
        <#assign formSpecificUrl = "/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3CphysicalDescription%3E%3CformSpecific%3E${formSpecificx}%3C%2FformSpecific%3E%3C%2FphysicalDescription%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=Pafcc42be-462c-483e-b2ed-98ffcd15ff3d&q=&sort=name&dr=AFTER" />
        <#if formSpecificx != "">
        <dd><strong>Drawing type</strong>:
            <#list formSpecific as formSpecific>
                ${formSpecific}<#if formSpecific_has_next>, </#if>
            </#list>
        </dd>
        </#if>
    </#list>

    <#if groupProject != "">
        <dd><strong>This was a(n)</strong>: <a href="${groupProjectUrl}">${groupProject}</a></dd>
    </#if>
    <#if groupProjectNumber != "">
        <dd>Group members: ${groupProjectNumber}</dd>
    </#if>
    <#if process != "">
        <dd>Division of labor in group: ${process}</dd>
    </#if>
    <#if groupConstituents != "">
        <dd>Group members were: <a href="${groupConstituentsUrl}">${groupConstituents}</a></dd>
    </#if>

    <#list local as local>
    <#assign tagx = local.get('tags')>
    <#if (tagx=="") || (tagx=="<null>")><#else>
        <dd><strong>Tags</strong>:
        <#list tag as tag>
            ${tag}<#if tag_has_next>, </#if>
        </#list></dd>
    </#if>
    </#list>

    <#list modslevel as mods>
        <#assign abstract = mods.get('abstract')>
        <#if abstract != ""><dd><strong>Summary</strong>: ${abstract}</dd></#if>
    </#list>

<div id='images'>
    <#list itemAttachments as itemAttachment>
        <#assign thumb = itemAttachment.get('thumbnail')>
        <#assign full = itemAttachment.get('file')>
        <#assign uuid = itemAttachment.get('uuid')>
        <div class="image-studentWork">
            <a href="/file/${itemUuid}/${itemversion}/${full}"><img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
            <#list part as part>
                <#assign file = part.get('number')>
                <#list part.getAllSubtrees('wrapperOther') as other>
                    <#assign format = other.get('format')>
                    <#assign formatSpecific = other.get('formatSpecific')>
                    <#assign assignNumber = other.get('assignNumber')>
                    <#assign exerciseNumber = other.get('exerciseNumber')>
                <#if file==uuid>
                    <p class='photoImagelist'>
                    <#if format != "">${format}</#if>
                    <#if format!=""><br /></#if>
                    <#if formatSpecific != "">${formatSpecific}</#if>
                    <#if formatSpecific!=""><br /></#if>
                    <#if assignNumber != "">Assgn: ${assignNumber}</#if>
                    <#if assignNumber!=""><br /></#if>
                    <#if exerciseNumber != "">Exercise: ${exerciseNumber}</#if>
                    <#if exerciseNumber!=""><br /></#if>
                    </p>
                </#if>
                </#list>
            </#list>
        </div>
    </#list>
    </div>

    <div style="clear:both;"></div>

</#if>
</#list>
