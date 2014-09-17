<#function escapeAmp str>
    <#-- returns a URI-encoded "&amp;"
    because we are passing XML in the URI, we have to escape this way -->
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
<#assign subject = xml.getAllSubtrees('mods/subject')>
<#assign relateditem = xml.getAllSubtrees('mods/relateditem')>
<#assign courseInfo = xml.getAllSubtrees('local/courseInfo')>
<#assign courseWork = xml.getAllSubtrees('local/courseWorkWrapper')>
<#assign local = xml.getAllSubtrees('local')>
<#assign origininfo = xml.getAllSubtrees('mods/origininfo')>
<#assign extentWrapper = xml.getAllSubtrees('local/extentWrapper')>
<#assign seniorPacket = xml.getAllSubtrees('local/seniorPacketWrapper')>

<style scoped>
/* disable links that point nowhere */
a[href=""] {
  color: #4b4842; /* default text color */
  pointer-events: none;
}
</style>

<dl>
<#list titleInfo as titleInfo>
    <#assign title = titleInfo.get('title')>
    <h2 id="title">${title}
    </h2></dl>
</#list>

<dt class="hide">Collection</dt>
<#list local as local>
    <#assign division = local.get('division')>
    <#assign department = local.get('department')>
    <#-- <dd>${division} -->
    <#assign divisionUrl = "/access/searching.do?doc=%3Cxml%2F%3E&in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&q=&sort=datemodified&dr=AFTER" />
    <#assign departmentUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&q=&sort=datemodified&dr=AFTER" />
    <dd class="collection">
        <a href="${departmentUrl}">${department}</a> | <a href="${divisionUrl}">${division}</a>
    </dd>
</#list>

<#list courseWork as courseWork>
    <#assign courseWorkType = courseWork.get('courseWorkType')>
    <#if (courseWorkType =="Course work")>
        <div id="images">
        <#list itemAttachments as itemAttachment>
            <#assign thumb = itemAttachment.get('thumbnail')>
            <#assign full = itemAttachment.get('file')>
            <#assign uuid = itemAttachment.get('uuid')>
            <#list seniorPacket as seniorPacket>
                <#assign title = seniorPacket.get('title')>
                <#assign jpgFile = seniorPacket.get('lowResFile')>
                <#assign tiffFile = seniorPacket.get('hiResFile')>
                <#if jpgFile==uuid>
                    <div class='image-studentWork'>
                        <a href="/file/${itemUuid}/${itemversion}/${full}" target="_blank">
                        <img src="/file/${itemUuid}/${itemversion}/${thumb}"/></a>
                        <p class='photoImagelist'>
                            <#if title != "">
                                <i>${title}</i>
                            </#if>
                                <br />
                                ${full}
                        </p>
                    </div>
                </#if>
            </#list>
        </#list>
        </div>
    </#if>
</#list>
<div style="clear:both;"></div>

<#assign name = xml.getAllSubtrees('mods/name')>
<#list name as name>
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
        <#assign majorUrl = "/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3Cname%3E%3CsubNameWrapper%3E%3Cmajor%3E${major}%3C%2Fmajor%3E%3C%2FsubNameWrapper%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&q=&sort=datemodified&dr=AFTER" />
        <#if description != "">
             — ${description}
        </#if>
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
    <#assign semesterUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Csemester%3E${semester}%3C%2Fsemester%3E%3C%2FcourseInfo%3E%3Cdepartment%3EGlass%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&sort=datemodified&dr=AFTER" />
    <#assign courseUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Ccourse%3E${escapeAmp(course)}%3C%2Fcourse%3E%3C%2FcourseInfo%3E%3Cdepartment%3EGlass%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&sort=datemodified&dr=AFTER" />
    <#assign facultyUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Cfaculty%3E${faculty}%3C%2Ffaculty%3E%3C%2FcourseInfo%3E%3Cdepartment%3EGlass%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&sort=datemodified&dr=AFTER" />
    <#assign sectionUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Csection%3E${section}%3C%2Fsection%3E%3C%2FcourseInfo%3E%3Cdepartment%3EGlass%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&sort=datemodified&dr=AFTER" />
    <#if semester != "">
        <dt>Course Info</dt>
        <span id="coursestuff"><a href="${semesterUrl}">${semester}</a>
            <#if (course != "undefined") && (course != "Events")>
                — <a href="${courseUrl}">${course}</a>
            </#if>
            <#if faculty != "undefined">
                — <a href="${facultyUrl}">${faculty}</a>
            </#if>
            <#if section != "undefined">
                — <a href="${sectionUrl}">${section}</a>
            </#if>
        </span>
    </#if>
</#list>


<#assign formSpecific = xml.getAllSubtrees('mods/physicalDescription/formSpecific')>
<#list physdesc as physdesc>
    <#-- only one formBroad, multiple formSpecific -->
    <#assign formBroad = physdesc.get('formBroad')>
    <#assign formSpecificx = physdesc.get('formSpecific')>

<#assign material = xml.getAllSubtrees('local/courseWorkWrapper/material')>
<#assign process = xml.getAllSubtrees('local/courseWorkWrapper/process')>
<#list courseWork as courseWork>
    <#assign courseWorkType = courseWork.get('courseWorkType')>
    <#assign materialx = courseWork.get('material')>
    <#assign processx = courseWork.get('process')>
    <#-- groupProjectUrl not used anywhere? -->
    <#assign groupProjectUrl = "" />
    <#assign courseWorkTypeUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3E${courseWorkType}%3C%2FcourseWorkType%3E%3C%2FcourseWorkWrapper%3E%3Cdepartment%3EGlass%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&q=&sort=datemodified&dr=AFTER" />
    <#assign formBroadUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3E${courseWorkType}%3C%2FcourseWorkType%3E%3C%2FcourseWorkWrapper%3E%3Cdepartment%3EGlass%3C%2Fdepartment%3E%3C%2Flocal%3E%3Cmods%3E%3CphysicalDescription%3E%3CformBroad%3E${formBroad}%3C%2FformBroad%3E%3C%2FphysicalDescription%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&q=&sort=datemodified&dr=AFTER" />
    <dt>Description</dt>
    <dd><a href="${courseWorkTypeUrl}">${courseWorkType}</a>
    <#if formBroad != "">
         — <a href="${formBroadUrl}">${formBroad}</a>
    </#if>

    <#if formSpecificx != "">
     —
        <#list formSpecific as formSpecific>
            <#assign formSpecificString = formSpecific.get('') />
            <#-- we need to use dept, courseWorkType, & formBroad here
            in order to get formSpecific to show up in Power Search -->
            <#assign formSpecificUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3E${courseWorkType}%3C%2FcourseWorkType%3E%3C%2FcourseWorkWrapper%3E%3Cdepartment%3EGlass%3C%2Fdepartment%3E%3C%2Flocal%3E%3Cmods%3E%3CphysicalDescription%3E%3CformSpecific%3E${formSpecificString}%3C%2FformSpecific%3E%3CformBroad%3E${formBroad}%3C%2FformBroad%3E%3C%2FphysicalDescription%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&q=&sort=datemodified&dr=AFTER" />
            <a href="${formSpecificUrl}">${formSpecificString}</a><#if formSpecific_has_next>, </#if>
        </#list>
        </dd>
    </#if>

    <#if materialx != "">
        <dd>Mixed media material(s):
        <#list material as material>
            <#if material != "">
                ${material}<#if material_has_next>, </#if>
            </#if>
        </#list>
        </dd>
    </#if>

    <#if processx != "">
        <dd>Technique(s):
        <#list process as process>
            <#assign processString = process.get('')>
            <#-- URL requires (hard-coded) dept, courseWorkType, & formBroad -->
            <#assign processUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3E${courseWorkType}%3C%2FcourseWorkType%3E%3Cprocess%3E${processString}%3C%2Fprocess%3E%3C%2FcourseWorkWrapper%3E%3Cdepartment%3EGlass%3C%2Fdepartment%3E%3C%2Flocal%3E%3Cmods%3E%3CphysicalDescription%3E%3CformBroad%3E${formBroad}%3C%2FformBroad%3E%3C%2FphysicalDescription%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&q=&sort=datemodified&dr=AFTER">
            <a href="${processUrl}">${process}</a><#if process_has_next>, </#if>
        </#list>
        </dd>
    </#if>
</#list>
</#list>

<#list extentWrapper as extentWrapper>
    <#assign height = extentWrapper.get('heightINCH')>
    <#assign width = extentWrapper.get('widthINCH')>
    <#assign depth = extentWrapper.get('depthINCH')>
    <#if height != "">
        <dd>Measurements (in inches): ${height}H x ${width}W x ${depth}D</dd>
    </#if>
</#list>

<#list origininfo as origininfo>
    <#assign dateCreated = origininfo.get('dateCreatedWrapper/dateCreated')>
    <dd>Date created:
        <#if dateCreated == "">
            <em>(No date given)</em>
        <#else>
            ${dateCreated}
        </#if>
    </dd>
</#list>

<#list modslevel as mods>
    <#assign abstract = mods.get('abstract')>
    <#if abstract != "">
        <dd>Additional notes: ${abstract}</dd>
    </#if>
</#list>
