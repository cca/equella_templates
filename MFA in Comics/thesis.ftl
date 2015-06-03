<#assign itemUuid = xml.get('item/@id')>
<#assign itemversion = xml.get('item/@version')>
<#assign itemAttachments = xml.getAllSubtrees('item/attachments/attachment')>
<#assign name = xml.getAllSubtrees('mods/name')>
<#assign courseInfo = xml.getAllSubtrees('local/courseInfo')>

<#if xml.get('local/courseWorkWrapper/courseWorkType') == 'Thesis'>
<dl>

<dt class="hide">Collection</dt>
	<#assign division = xml.get('local/division')>
	<#assign department = xml.get('local/department')>
	<#assign divisionUrl = "" />
	<#assign departmentUrl = "" />
	<dd class="collection">${department} | ${division}</dd>

    <#assign title = xml.get('mods/titleInfo/title')>
    <h2 id="title">${title}</h2>

<div id="images">
    <#list itemAttachments as itemAttachment>
        <#assign uuid = itemAttachment.get('uuid')>
        <#assign full = itemAttachment.get('file')>
        <a href="/file/${itemUuid}/${itemversion}/${full}">
        <img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
    </#list>
</div>

<#list name as name>
    <#assign namePart = name.get('namePart')>
    <dd><b>Author</b>: ${namePart}
        <#assign major = name.get('subNameWrapper/major')>
        <#if major != "">
            <#assign majorUrl = "" />
            &nbsp;-&nbsp; ${major}
        </#if>
    </dd>
</#list>

<#list courseInfo as courseInfo>
    <#assign semester = courseInfo.get('semester')>
    <#assign semesterUrl = "" />
    <#if (semester != "")>
	<dd><b>Graduating semester</b>: ${semester}</dd>
	</#if>
</#list>

<#assign facultyS = xml.list('local/courseInfo/faculty')>
<#if (facultyS?size > 0)>
    <dd><b>Mentor(s)</b>:
	<#list facultyS as faculty>
		${faculty}<#if faculty_has_next>, </#if>
	</#list>
    </dd>
</#if>

<#assign formBroadS = xml.list('mods/physicalDescription/formBroad')>
<dd><b>Work type</b>:
    <#assign courseWorkType = xml.get('local/courseWorkWrapper/courseWorkType')>
    <#if courseWorkType != "">
        <#assign courseWorkTypeUrl = "" />
        ${courseWorkType}
    </#if>
    <#if (formBroadS?size > 0)>
	<#list formBroadS as format>
		- ${format}<#if format_has_next>, </#if>
	</#list>
    </dd>
</#if>

<#assign genres = xml.list('mods/genreWrapper/genre')>
<#if (genres?size > 0)>
    <dd><b>Genre(s)</b>:
    <#list genres as genre>
        ${genre}<#if genre_has_next>, </#if>
    </#list>
    </dd>
</#if>

</#if>
