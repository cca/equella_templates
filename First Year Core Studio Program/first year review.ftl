<#assign itemUuid = xml.get('item/@id')>
<#assign itemversion = xml.get('item/@version')>
<#assign itemAttachments = xml.getAllSubtrees('item/attachments/attachment')>

<dl>
<#list xml.getAllSubtrees('local/courseWorkWrapper') as courseWork>
<#if (courseWork.get('courseWorkType') =="First Year Review")>

    <#assign title = xml.get('mods/titleInfo/title')>
    <h2 id="title">${title}</h2>

    <#list xml.getAllSubtrees('mods/part/number') as presentation>
        <#list itemAttachments as itemAttachment>
            <#if presentation.get('/') = itemAttachment.get('uuid')>
                <#assign full = itemAttachment.get('file')>
                <#assign uuid = itemAttachment.get('uuid')>
                <div class="image-artistDocs">
                    <p class='artistDocs'><i><u><strong>Presentation</strong></i></u></p>
                    <a href="/file/${itemUuid}/${itemversion}/${full}" target="_blank">
                    <img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
                    <p class='artistDocs'>${full}</p>
                </div>
            </#if>
        </#list>
    </#list>

    <#list xml.getAllSubtrees('mods/part/numberB') as writtenResponse>
        <#list itemAttachments as itemAttachment>
            <#if writtenResponse.get('/') = itemAttachment.get('uuid')>
                <#assign full = itemAttachment.get('file')>
                <#assign uuid = itemAttachment.get('uuid')>
                <div class="image-artistDocs">
                    <p class='artistDocs'><i><u><strong>Written Response</strong></i></u></p>
                    <a href="/file/${itemUuid}/${itemversion}/${full}" target="_blank">
                    <img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
                    <p class='artistDocs'>${full}</p>
                </div>
            </#if>
        </#list>
    </#list>

    <dt>Description</dt>
    <#assign namePart = xml.get('mods/name/namePart')>
    <dd><strong>Student:</strong> ${namePart}
    <#list xml.getAllSubtrees('mods/name/subNameWrapper') as subName>
        <#assign major = subName.get('major')>
        <#assign majorUrl = "" />
        <#if (major != "")>
             — <a href="${majorUrl}">${major}</a>
        </#if>
    </#list>

    <#assign academicLevel = xml.get('local/academicLevel')>
    <#assign academicLevelUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CacademicLevel%3E${academicLevel}%3C%2FacademicLevel%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P6f96efa5-24ab-4bb8-ad27-169df9f9560d&q=&sort=datemodified&dr=AFTER" />
        <#if (academicLevel=="")>
            <#else> — <a href="${academicLevelUrl}">${academicLevel}</a>
        </#if>
    </dd>

    <#list xml.getAllSubtrees('local/courseInfo') as courseInfo>
        <#assign semester = courseInfo.get('semester')>
        <#assign department = courseInfo.get('department')>
        <#assign semesterUrl = "" />
        <dd><strong>Semester of review:</strong> ${semester}</dd>
    </#list>

    <#list xml.getAllSubtrees('mods/physicalDescription') as physdesc>
        <#assign formBroad = physdesc.get('formBroad')>
        <#if (formBroad != "")>
        <dt>Project Description</dt></#if>
        <dd>Work type: ${formBroad}</dd>
    </#list>

    <#assign materials = courseWork.list('material')>
    <#assign materialsText = courseWork.get('materials_freetext')>
    <#assign groupProject = courseWork.get('groupProject')>
    <#if (materials?size != 0)>
        <dd>Material(s):
            <#list materials as material>
                ${material}<#if material_has_next>; </#if>
            </#list>
        </dd>
    </#if>
    <#if (materialsText != "")>
        <dd>Other materials: ${materialsText}</dd>
    </#if>
    <#if (groupProject != "")>
        <dd>Project type: ${groupProject}</dd>
    </#if>

    <#assign abstract = xml.get('mods/abstract')>
    <#if (abstract != "")>
        <dd>Description:<br><pre>${abstract}</pre></dd>
    </#if>

</#if>
</#list>
