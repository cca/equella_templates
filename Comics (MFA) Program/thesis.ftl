<#assign itemUuid = xml.get('item/@id')>
<#assign itemversion = xml.get('item/@version')>
<#assign itemAttachments = xml.getAllSubtrees('item/attachments/attachment')>
<#assign courseWorkType = xml.get('local/courseWorkWrapper/courseWorkType')>

<#if courseWorkType == 'Thesis' || courseWorkType == 'Graduate First Year Review'>
<dl>

<dt class="hide">Collection</dt>
	<#assign division = xml.get('local/division')>
	<#assign department = xml.get('local/department')>
	<#assign divisionUrl = "">
	<#assign departmentUrl = "">
	<dd class="collection">${department} | ${division}</dd>

    <#assign title = xml.get('mods/titleInfo/title')>
	<#assign subTitle = xml.get('mods/titleInfo/subTitle')>
    <h2 id="title">
		<#if subTitle != "">
			${subTitle}
		<#else>
			${title}
		</#if>
	</h2>

<div id="images">
    <#list itemAttachments as attachment>
        <#assign uuid = attachment.get('uuid')>
        <#assign file = attachment.get('file')>
        <a href="/file/${itemUuid}/${itemversion}/${file}" rel="group">
        <img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
    </#list>
</div>

<#list xml.getAllSubtrees('mods/name') as name>
    <#assign namePart = name.get('namePart')>
    <dd><b>Author</b>: ${namePart}
        <#assign major = name.get('subNameWrapper/major')>
        <#if major != "">
            <#assign majorUrl = "" />
            &nbsp;-&nbsp; ${major}
        </#if>
    </dd>
</#list>

<#list xml.getAllSubtrees('local/courseInfo') as courseInfo>
    <#assign semester = courseInfo.get('semester')>
    <#assign semesterUrl = "">
    <#if semester != "">
	<dd><b>Graduating semester</b>: ${semester}</dd>
	</#if>
</#list>

<#assign faculties = xml.list('local/courseInfo/faculty')>
<#if (faculties?size > 0)>
    <dd><b>Mentor(s)</b>:
	<#list faculties as faculty>
		${faculty}<#if faculty_has_next>, </#if>
	</#list>
    </dd>
</#if>

<#assign formBroads = xml.list('mods/physicalDescription/formBroad')>
<dd><b>Work type</b>:
	<#assign courseWorkTypeUrl = "">
	<#-- mask the standardized metadata value by showing what
	users see in the contribution form	-->
    <#if courseWorkType == "Graduate First Year Review">
		First Year Thesis Packet
	<#else>
        ${courseWorkType}
    </#if>
    <#if (formBroads?size > 0)>
	<#list formBroads as format>
		- ${format}<#if format_has_next>, </#if>
	</#list>
    </dd>
</#if>

<#assign materials = xml.list('/local/courseWorkWrapper/material')>
<#if materials?size != 0>
<dd><b>Materials Included</b>:
	<#list materials as material>
		${material}<#if material_has_next>, </#if>
	</#list>
</dd>
</#if>

<#assign genres = xml.list('mods/genreWrapper/genre')>
<#if genres?size != 0>
    <dd><b>Genre(s)</b>:
    <#list genres as genre>
        ${genre}<#if genre_has_next>, </#if>
    </#list>
    </dd>
</#if>

</#if>
