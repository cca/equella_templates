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
<#assign courseInfo = xml.getAllSubtrees('local/courseInfo')>
<#assign courseWork = xml.getAllSubtrees('local/courseWorkWrapper')>
<#assign local = xml.getAllSubtrees('local')>

<style scoped>
/* disable links that point nowhere */
a[href=""] {
  color: #4b4842; /* default text color */
  pointer-events: none;
}
</style>

<dl>
<#list courseWork as courseWork>
<#assign courseWorkType = courseWork.get('courseWorkType')>
<#if (courseWorkType =="Course work")>

	<#list titleInfo as titleInfo>
		<#assign title = titleInfo.get('title')>
		<#assign subTitle = titleInfo.get('subTitle')>
		<h2 id="title">${title}</h2>
		</dl>
	</#list>

	<dt class="hide">Collection</dt>
		<#list local as local>
			<#assign division = local.get('division')>
			<#assign department = local.get('department')>
			<#assign divisionUrl = "https://vault.cca.edu/access/searching.do?doc=%3Cxml%2F%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />
			<#assign departmentUrl = "https://vault.cca.edu/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />

			<dd class="collection"><a href="${departmentUrl}">${department}</a> | <a href="${divisionUrl}">${division}</a></dd>
		</#list>

		<div id="images">
			<#list itemAttachments as itemAttachment>
				<#assign thumb = itemAttachment.get('thumbnail')>
				<#assign full = itemAttachment.get('file')>
				<#if full?contains("http://") || full?ends_with(".zip")><#else>
					<a href="https://vault.cca.edu/file/${itemUuid}/${itemversion}/${full}">
					<img src="https://vault.cca.edu/file/${itemUuid}/${itemversion}/${thumb}"/></a>
				</#if>
			</#list>
		</div>

	<#assign name = xml.getAllSubtrees('mods/name')>
	<#list name as name>
		<#assign namePart = name.get('namePart')>
		<#if name_index == 0 && namePart != "">
			<dt>Creator</dt><#else>
		</#if>
		<#if namePart != "">
			<dd>${namePart}
		</#if>
		<#list name.getAllSubtrees('subNameWrapper') as subName>
			<#assign major = subName.get('major')>
			<#assign majorUrl = "https://vault.cca.edu/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3Cname%3E%3CsubNameWrapper%3E%3Cmajor%3E${major}%3C%2Fmajor%3E%3C%2FsubNameWrapper%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />

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
		<#assign courseUrl = "https://vault.cca.edu/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Ccourse%3E${escapeAmp(course)}%3C%2Fcourse%3E%3C%2FcourseInfo%3E%3Cdepartment%3EIndustrial+Design%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />
		<#assign semesterUrl = "https://vault.cca.edu/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Csemester%3EFall+2013%3C%2Fsemester%3E%3C%2FcourseInfo%3E%3Cdepartment%3EIndustrial+Design%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />
		<#assign facultyUrl = "https://vault.cca.edu/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Cfaculty%3E${faculty}%3C%2Ffaculty%3E%3C%2FcourseInfo%3E%3Cdepartment%3EIndustrial+Design%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />
		<#assign sectionUrl = "https://vault.cca.edu/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Csection%3E${section}%3C%2Fsection%3E%3C%2FcourseInfo%3E%3Cdepartment%3EIndustrial+Design%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />
		<#assign courseCategoryUrl = "https://vault.cca.edu/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3CcourseCategory%3E${courseCategory}%3C%2FcourseCategory%3E%3CspecialPrograms%3E${specialPrograms}%3C%2FspecialPrograms%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />
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
		<#if courseCategory != "">
			<dd>Course category: <a href="${courseCategoryUrl}">${courseCategory}</a></dd>
		</#if>
	</#list>

		<#assign workType = courseWork.get('workType')>
		<#assign courseWorkTypeSpecific = courseWork.get('courseWorkTypeSpecific')>
		<#assign groupMembers = courseWork.get('groupMembers')>
		<#assign groupContribution = courseWork.get('groupContribution')>
		<#assign courseWorkTypeUrl = "https://vault.cca.edu/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3E${courseWorkType}%3C%2FcourseWorkType%3E%3C%2FcourseWorkWrapper%3E%3Cdepartment%3EIndustrial+Design%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />
		<#assign workTypeUrl = "https://vault.cca.edu/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseWorkWrapper%3E%3CworkType%3E${workType}%3C%2FworkType%3E%3C%2FcourseWorkWrapper%3E%3Cdepartment%3EIndustrial+Design%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />
		<dt>Description</dt>
		<dd>
		<#if courseWorkType == "">{undefined submission type}<#else>
			<a href="${courseWorkTypeUrl}">${courseWorkType}</a>
		</#if>
		<#if workType != "">
			 — <a href="${workTypeUrl}">${workType}</a>
		</#if>

		<#assign formBroad = xml.getAllSubtrees('mods/physicalDescription/formBroad')>
		<#assign formSpecific = xml.getAllSubtrees('mods/physicalDescription/formSpecific')>
		<#list physdesc as physdesc>
			<#assign formBroadx = physdesc.get('formBroad')>
			<#assign formSpecificx = physdesc.get('formSpecific')>
			<#if formBroadx != "">
				<#-- formBroad is an XML subtree -->
				 — <#list formBroad as formBroad>
				 	<#assign formBroadString = formBroad.get('/')>
				 	<#assign formBroadUrl = "https://vault.cca.edu/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3E${courseWorkType}%3C%2FcourseWorkType%3E%3C%2FcourseWorkWrapper%3E%3Cdepartment%3EIndustrial+Design%3C%2Fdepartment%3E%3C%2Flocal%3E%3Cmods%3E%3CphysicalDescription%3E%3CformBroad%3E${formBroadString}%3C%2FformBroad%3E%3C%2FphysicalDescription%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER">
					<a href="${formBroadUrl}">${formBroadString}</a><#if formBroad_has_next>, </#if>
				</#list>
			</#if>
			<#if formSpecificx != "">
				<#-- same situation as above: loop over XML nodes -->
				 — <#list formSpecific as formSpecific>
				 	<#assign formSpecificString = formSpecific.get('/')>
				 	<#assign formSpecificUrl = "https://vault.cca.edu/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3E${courseWorkType}%3C%2FcourseWorkType%3E%3C%2FcourseWorkWrapper%3E%3Cdepartment%3EIndustrial+Design%3C%2Fdepartment%3E%3C%2Flocal%3E%3Cmods%3E%3CphysicalDescription%3E%3CformSpecific%3E${formSpecificString}%3C%2FformSpecific%3E%3C%2FphysicalDescription%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER">
					<a href="${formSpecificUrl}">${formSpecificString}</a><#if formSpecific_has_next>, </#if>
				</#list>
			</#if>
		</#list>

		<#if courseWorkTypeSpecific != "">
			<#assign courseWorkTypeSpecificUrl = "https://vault.cca.edu/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseWorkWrapper%3E%3CcourseWorkTypeSpecific%3E${courseWorkTypeSpecific}%3C%2FcourseWorkTypeSpecific%3E%3CcourseWorkType%3ECourse+work%3C%2FcourseWorkType%3E%3C%2FcourseWorkWrapper%3E%3Cdepartment%3EIndustrial+Design%3C%2Fdepartment%3E%3Ctags%2F%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />
			 — <a href="${courseWorkTypeSpecificUrl}">${courseWorkTypeSpecific}</a>
		</#if>
		<#list local as local>
			<#-- list() returns a list of text inside nodes -->
			<#assign tags = xml.list('local/tags')>
			<#if tags?size != 0>
				 — <#list tags as tag>
				 	<#-- assign URL inside of loop -->
					<#assign tagUrl = "https://vault.cca.edu/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseWorkWrapper%2F%3E%3Ctags%3E${tag}%3C%2Ftags%3E%3C%2Flocal%3E%3Cmods%3E%3CphysicalDescription%2F%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />
					<a href="${tagUrl}">${tag}</a><#if tag_has_next>, </#if>
				</#list>
			</#if>
		</#list>
	</dd>

	<#list itemAttachments as itemAttachment>
		<#assign type = itemAttachment.get('@type')>
		<#assign full = itemAttachment.get('file')>
		<#if type == "remote">
			<dd>Related link: <a href="${full}">${full}</a></dd>
		</#if>
	</#list>

	<#list modslevel as mods>
		<#assign abstract = mods.get('abstract')>
		<#if abstract != "">
			<dd>${abstract}</dd>
		</#if>
	</#list>

	<dd>
		<#assign groupProject = courseWork.get('groupProject')>
		<#assign groupProjectUrl = "https://vault.cca.edu/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3E${courseWorkType}%3C%2FcourseWorkType%3E%3CgroupProject%3E${groupProject}%3C%2FgroupProject%3E%3C%2FcourseWorkWrapper%3E%3Cdepartment%3EIndustrial+Design%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />
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
