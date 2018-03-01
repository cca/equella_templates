<#function escapeAmp str>
    <#-- returns a URI-encoded "&amp;"
    because we pass XML in the URI, we have to escape this way -->
    <#return str?replace('&', '%26amp%3B')>
</#function>
<#assign itemUuid = xml.get('item/@id')>
<#assign itemversion = xml.get('item/@version')>
<#assign itemAttachments = xml.getAllSubtrees('item/attachments/attachment')>
<#assign courseWorkType = xml.get('local/courseWorkWrapper/courseWorkType')>
<#assign powerSearch = 'Pe78fd93a-86cd-40a9-9382-e86897646a2d'>

<#if courseWorkType == 'Course work'>
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

<dt>Course Information</dt>
<#list xml.getAllSubtrees('local/courseInfo') as courseInfo>
	<#assign department = courseInfo.get('department')>
	<#assign semester = courseInfo.get('semester')>
	<#assign course = courseInfo.get('course')>
	<#assign faculty = courseInfo.get('faculty')>
	<#assign section = courseInfo.get('section')>
	<#assign courseCategory = courseInfo.get('courseCategory')>
	<#assign specialPrograms = courseInfo.get('specialPrograms')>
	<#assign semesterUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Csemester%3E${semester}%3C%2Fsemester%3E%3C%2FcourseInfo%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&sort=datemodified&dr=AFTER" />
	<#assign courseUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Ccourse%3E${escapeAmp(course)}%3C%2Fcourse%3E%3C%2FcourseInfo%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=&sort=datemodified&dr=AFTER" />
	<#assign facultyUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Cfaculty%3E${faculty}%3C%2Ffaculty%3E%3C%2FcourseInfo%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=&sort=datemodified&dr=AFTER" />
	<#assign sectionUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Csection%3E${section}%3C%2Fsection%3E%3C%2FcourseInfo%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=&sort=datemodified&dr=AFTER" />
	<dd>
		<#if semester != "">
			<a href="${semesterUrl}">${semester}</a>
		</#if>
		<#if semester != "" && course != ""> - </#if>
		<#if course != "">
			<a href="${courseUrl}">${course}</a> —
		</#if>
		<#if faculty!= "">
			<a href="${facultyUrl}">${faculty}</a> —
		</#if>
		<#if section!= "">
			<a href="${sectionUrl}">${section}</a>
		</#if>
	</dd>
</#list>

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

<#assign abstract = xml.get('mods/abstract')>
<#if abstract != ''>
    <dd><b>Abstract</b>:<br>
<pre>${abstract}</pre>
    </dd>
</#if>

</#if>
