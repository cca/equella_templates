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

<dl>
<#assign material = xml.getAllSubtrees('local/courseWorkWrapper/material')>
<#list courseWork as courseWork>
<#assign courseWorkType = courseWork.get('courseWorkType')>
<#if (courseWorkType =="First Year Review")>

    <#list titleInfo as titleInfo>
        <#assign title = titleInfo.get('title')>
        <h2 id="title">${title}
        </h2>
    </#list>

    <#list xml.getAllSubtrees('mods/part/number') as presentation>
    <#list itemAttachments as itemAttachment>
        <#if presentation.get('/') = itemAttachment.get('uuid')>
            <#assign thumb = itemAttachment.get('thumbnail')>
            <#assign full = itemAttachment.get('file')>
            <#assign uuid = itemAttachment.get('uuid')>
            <div class="image-artistDocs">
                <p class='artistDocs'><i><u><strong>Presentation</strong></i></u></p>
                <a href="https://vault.cca.edu/file/${itemUuid}/${itemversion}/${full}" target="_blank">
                <img src="https://vault.cca.edu/file/${itemUuid}/${itemversion}/${thumb}"/></a>
                <p class='artistDocs'>${full}</p>
            </div>
        </#if>
    </#list>
    </#list>

    <#list xml.getAllSubtrees('mods/part/numberB') as writtenResponse>
    <#list itemAttachments as itemAttachment>
        <#if writtenResponse.get('/') = itemAttachment.get('uuid')>
            <#assign thumb = itemAttachment.get('thumbnail')>
            <#assign full = itemAttachment.get('file')>
            <#assign uuid = itemAttachment.get('uuid')>
            <div class="image-artistDocs">
                <p class='artistDocs'><i><u><strong>Written Response</strong></i></u></p>
                <a href="https://vault.cca.edu/file/${itemUuid}/${itemversion}/${full}" target="_blank">
                <img src="https://vault.cca.edu/file/${itemUuid}/${itemversion}/${thumb}"/></a>
                <p class='artistDocs'>${full}</p>
            </div>
        </#if>
    </#list>
    </#list>

    <dt>Description</dt>
    <#list name as name>
        <#assign namePart = name.get('namePart')>
        <dd><strong>Student:</strong> ${namePart}
        <#list name.getAllSubtrees('subNameWrapper') as subName>
            <#assign major = subName.get('major')>
            <#-- <dd>${major} -->
            <#assign majorUrl = "" />
            <#if (major=="")><#else>
                 — ${major}
            </#if>
        </#list>
    </#list>

    <#list local as local>
        <#assign academicLevel = local.get('academicLevel')>
        <#-- <dd>${academicLevel} -->
        <#assign academicLevelUrl = "https://vault.cca.edu/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CacademicLevel%3E${academicLevel}%3C%2FacademicLevel%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P6f96efa5-24ab-4bb8-ad27-169df9f9560d&q=&sort=datemodified&dr=AFTER" />
            <#if (academicLevel=="")>
                <#else> — <a href="${academicLevelUrl}">${academicLevel}</a>
            </#if>
        </dd>
    </#list>


    <#list courseInfo as courseInfo>
        <#assign semester = courseInfo.get('semester')>
        <#assign department = courseInfo.get('department')>
        <#-- <dd>${department} -->
        <#-- <dd>${semester} -->
        <#assign semesterUrl = "" />
        <dd><strong>Semester of review:</strong> ${semester}</dd>
    </#list>

    <#list physdesc as physdesc>
        <#assign formBroad = physdesc.get('formBroad')>
        <#if (formBroad=="")><#else>
        <dt>Project Description</dt></#if>
        <dd>Work type: ${formBroad}</dd>
    </#list>

    <#assign materialx = courseWork.get('material')>
    <#assign materialsText = courseWork.get('materials_freetext')>
    <#assign groupProject = courseWork.get('groupProject')>
    <#if (materialx=="")><#else>
        <dd>Material(s):
            <#list material as material>
                ${material}<#if material_has_next>; </#if>
            </#list>
        </dd>
    </#if>
    <#if (materialsText=="")><#else>
        <dd>Other materials: ${materialsText}</dd>
    </#if>
    <#if (groupProject=="")><#else>
        <dd>Project type: ${groupProject}</dd>
    </#if>

    <#list modslevel as mods>
        <#assign abstract = mods.get('abstract')>
        <#if (abstract=="")><#else>
            <dd>Description: ${abstract}</dd>
        </#if>
    </#list>

<#else></#if>
</#list>
