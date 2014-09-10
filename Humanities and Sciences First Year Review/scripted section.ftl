<#assign itemUuid = xml.get('item/@id')>
<#assign itemversion = xml.get('item/@version')>
<#assign title = xml.getAllSubtrees('mods/titleInfo')>
<#assign itemAttachments = xml.getAllSubtrees('item/attachments/attachment')>
<#assign name = xml.getAllSubtrees('mods/name')>
<#assign physdesc = xml.getAllSubtrees('mods/physicalDescription')>
<#assign modslevel = xml.getAllSubtrees('mods')>
<#assign courseInfo = xml.getAllSubtrees('local/courseInfo')>
<#assign juniorReview = xml.getAllSubtrees('local/juniorReviewWrapper')>
<#assign local = xml.getAllSubtrees('local')>

<dl>

    <#list title as titleInfo>
        <#assign title = titleInfo.get('title')>
        <h2 id="title">${title}
        </h2>
    </#list>


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


    <#list courseInfo as courseInfo>
        <#assign semester = courseInfo.get('semester')>
        <#assign department = courseInfo.get('department')>
        <#-- <dd>${department} -->
        <#-- <dd>${semester} -->
        <#assign semesterUrl = "" />
        <dd><strong>Semester of review:</strong> ${semester}</dd>
    </#list>

<#list xml.getAllSubtrees('local/juniorReviewWrapper/file') as portfolio>
    <#list itemAttachments as itemAttachment>
        <#if portfolio.get('/') = itemAttachment.get('uuid')>
            <#assign full = itemAttachment.get('file')>
            <#assign uuid = itemAttachment.get('uuid')>
            <dd><strong>Writing Portfolio:</strong> ${full}</dd>
        </#if>
    </#list>
</#list>

<#list xml.getAllSubtrees('local/artistDocWrapper/artistStatementFile') as writtenResponse>
    <#list itemAttachments as itemAttachment>
        <#if writtenResponse.get('/') = itemAttachment.get('uuid')>
            <#assign full = itemAttachment.get('file')>
            <#assign uuid = itemAttachment.get('uuid')>
            <dd><strong>Writer's Statement:</strong> ${full}</dd>
        </#if>
    </#list>
</#list>


    <#list modslevel as mods>
        <#assign abstract = mods.get('abstract')>
        <#if (abstract=="")><#else>
            <dd>Description: ${abstract}</dd>
        </#if>
    </#list>
