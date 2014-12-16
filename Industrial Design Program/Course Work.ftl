<#function escapeAmp str>
    <#-- returns a URI-encoded "&amp;"
    because we are passing XML in the URI, we have to escape this way -->
    <#return str?replace('&', '%26amp%3B')>
</#function>

<#assign itemUuid = xml.get('item/@id')>
<#assign itemversion = xml.get('item/@version')>
<#assign itemAttachments = xml.getAllSubtrees('item/attachments/attachment')>
<#assign courseInfo = xml.getAllSubtrees('local/courseInfo')>

<style scoped>
/* disable links that point nowhere */
a[href=""] {
  color: #4b4842; /* default text color */
  pointer-events: none;
}
</style>

<dl>
<#list xml.getAllSubtrees('local/courseWorkWrapper') as courseWork>
<#assign courseWorkType = courseWork.get('courseWorkType')>
<#if (courseWorkType == "Course work")>

	<#assign title = xml.get('mods/titleInfo/title')>
	<h2 id="title">${title}</h2>
</dl>

	<dt class="hide">Collection</dt>
	<#assign division = xml.get('local/division')>
	<#assign department = xml.get('local/department')>
	<#assign divisionUrl = "/access/searching.do?doc=%3Cxml%2F%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />
	<#assign departmentUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />
	<dd class="collection"><a href="${departmentUrl}">${department}</a> | <a href="${divisionUrl}">${division}</a></dd>

	<div id="images">
		<#list itemAttachments as itemAttachment>
			<#assign uuid = itemAttachment.get('uuid')>
			<#assign full = itemAttachment.get('file')>
			<#if !full?contains("http://") || !full?ends_with(".zip")>
				<a href="/file/${itemUuid}/${itemversion}/${full}">
				<img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
			</#if>
		</#list>
	</div>

	<#list xml.getAllSubtrees('mods/name') as name>
		<#assign namePart = name.get('namePart')>
		<#if name_index == 0 && namePart != "">
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
		<#assign department = courseInfo.get('department')>
		<#assign semester = courseInfo.get('semester')>
		<#assign course = courseInfo.get('course')>
		<#assign faculty = courseInfo.get('faculty')>
		<#assign section = courseInfo.get('section')>
		<#assign courseCategory = courseInfo.get('courseCategory')>
		<#assign specialPrograms = courseInfo.get('specialPrograms')>
		<#assign courseUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Ccourse%3E${escapeAmp(course)}%3C%2Fcourse%3E%3C%2FcourseInfo%3E%3Cdepartment%3EIndustrial+Design%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />
		<#assign semesterUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Csemester%3EFall+2013%3C%2Fsemester%3E%3C%2FcourseInfo%3E%3Cdepartment%3EIndustrial+Design%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />
		<#assign facultyUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Cfaculty%3E${faculty}%3C%2Ffaculty%3E%3C%2FcourseInfo%3E%3Cdepartment%3EIndustrial+Design%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />
		<#assign sectionUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Csection%3E${section}%3C%2Fsection%3E%3C%2FcourseInfo%3E%3Cdepartment%3EIndustrial+Design%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />
		<#assign courseCategoryUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3CcourseCategory%3E${courseCategory}%3C%2FcourseCategory%3E%3CspecialPrograms%3E${specialPrograms}%3C%2FspecialPrograms%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />
		<dt>Course Info</dt>
		<span id="coursestuff">
			<#if semester != "">
				<a href="${semesterUrl}">${semester}</a>
			</#if>
			<#if (course != "undefined" && course != "Events")>
				— <a href="${courseUrl}">${course}</a>
			</#if>
			<#if (faculty != "undefined" && faculty != "")>
				— <a href="${facultyUrl}">${faculty}</a>
			</#if>
			<#if (section != "undefined" && section != "")>
				— <a href="${sectionUrl}">${section}</a>
			</#if>
		</span>
		<#if courseCategory != "">
			<dd>Course category: <a href="${courseCategoryUrl}">${courseCategory}</a></dd>
		</#if>
	</#list>

	<#assign workType = courseWork.get('workType')>
	<#assign courseWorkTypeSpecific = courseWork.get('courseWorkTypeSpecific')>
	<#assign groupMembers = courseWork.get('groupMembers')>
	<#assign groupContribution = courseWork.get('groupContribution')>
	<#assign courseWorkTypeUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3E${courseWorkType}%3C%2FcourseWorkType%3E%3C%2FcourseWorkWrapper%3E%3Cdepartment%3EIndustrial+Design%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />
	<#assign workTypeUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseWorkWrapper%3E%3CworkType%3E${workType}%3C%2FworkType%3E%3C%2FcourseWorkWrapper%3E%3Cdepartment%3EIndustrial+Design%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />
	<dt>Description</dt>
	<dd>
		<#if courseWorkType == "">undefined submission type<#else>
			<a href="${courseWorkTypeUrl}">${courseWorkType}</a>
		</#if>
		<#if workType != "">
			 — <a href="${workTypeUrl}">${workType}</a>
		</#if>

		<#list xml.getAllSubtrees('mods/physicalDescription') as physdesc>
			<#assign formBroads = physdesc.list('formBroad')>
			<#assign formSpecifics = physdesc.list('formSpecific')>
			<#if formBroads?size != 0>
				 — <#list formBroads as formBroad>
				 	<#assign formBroadUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3E${courseWorkType}%3C%2FcourseWorkType%3E%3C%2FcourseWorkWrapper%3E%3Cdepartment%3EIndustrial+Design%3C%2Fdepartment%3E%3C%2Flocal%3E%3Cmods%3E%3CphysicalDescription%3E%3CformBroad%3E${formBroad}%3C%2FformBroad%3E%3C%2FphysicalDescription%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER">
					<a href="${formBroadUrl}">${formBroad}</a><#if formBroad_has_next>, </#if>
				</#list>
			</#if>
			<#if formSpecifics?size != 0>
				 — <#list formSpecifics as formSpecific>
				 	<#assign formSpecificUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3E${courseWorkType}%3C%2FcourseWorkType%3E%3C%2FcourseWorkWrapper%3E%3Cdepartment%3EIndustrial+Design%3C%2Fdepartment%3E%3C%2Flocal%3E%3Cmods%3E%3CphysicalDescription%3E%3CformSpecific%3E${formSpecific}%3C%2FformSpecific%3E%3C%2FphysicalDescription%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER">
					<a href="${formSpecificUrl}">${formSpecific}</a><#if formSpecific_has_next>, </#if>
				</#list>
			</#if>
		</#list>

		<#if courseWorkTypeSpecific != "">
			<#assign courseWorkTypeSpecificUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseWorkWrapper%3E%3CcourseWorkTypeSpecific%3E${courseWorkTypeSpecific}%3C%2FcourseWorkTypeSpecific%3E%3CcourseWorkType%3ECourse+work%3C%2FcourseWorkType%3E%3C%2FcourseWorkWrapper%3E%3Cdepartment%3EIndustrial+Design%3C%2Fdepartment%3E%3Ctags%2F%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />
			 — <a href="${courseWorkTypeSpecificUrl}">${courseWorkTypeSpecific}</a>
		</#if>
		<#-- list() returns a list of text inside nodes -->
		<#assign tags = xml.list('local/tags')>
		<#if tags?size != 0>
			 — <#list tags as tag>
			 	<#-- assign URL inside of loop -->
				<#assign tagUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseWorkWrapper%2F%3E%3Ctags%3E${tag}%3C%2Ftags%3E%3C%2Flocal%3E%3Cmods%3E%3CphysicalDescription%2F%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />
				<a href="${tagUrl}">${tag}</a><#if tag_has_next>, </#if>
			</#list>
		</#if>
	</dd>

	<#list itemAttachments as itemAttachment>
		<#assign type = itemAttachment.get('@type')>
		<#assign full = itemAttachment.get('file')>
		<#if type == "remote">
			<dd>Related link: <a href="${full}">${full}</a></dd>
		</#if>
	</#list>

	<#assign abstract = xml.get('mods/abstract')>
	<#if abstract != "">
		<dd>${abstract}</dd>
	</#if>

	<dd>
		<#assign groupProject = courseWork.get('groupProject')>
		<#assign groupProjectUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3E${courseWorkType}%3C%2FcourseWorkType%3E%3CgroupProject%3E${groupProject}%3C%2FgroupProject%3E%3C%2FcourseWorkWrapper%3E%3Cdepartment%3EIndustrial+Design%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />
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
		<dd>Contribution: ${groupContribution}</dd>
	</#if>

</#if>
</#list>
