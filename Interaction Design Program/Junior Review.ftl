<#list xml.getAllSubtrees('local/courseWorkWrapper') as courseWork>
<#assign courseWorkType = courseWork.get('courseWorkType')>
<#if courseWorkType == "Junior Review">

<#function escapeAmp str>
    <#-- returns a URI-encoded "&amp;"
    because we are passing XML in the URI, we have to escape this way -->
    <#return str?replace('&', '%26amp%3B')>
</#function>

<#-- design division Power Search -->
<#assign powerSearch = 'P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3'>
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
	<#assign title = xml.get('mods/titleInfo/title')>
	<h2 id="title">${title}</h2>

	<dt class="hide">Collection</dt>
	<#assign division = xml.get('local/division')>
	<#assign department = xml.get('local/department')>
	<#assign divisionUrl = "/access/searching.do?doc=%3Cxml%2F%3E&in=${powerSearch}&q=&sort=datemodified&dr=AFTER" />
	<#assign departmentUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=&sort=datemodified&dr=AFTER" />
	<dd class="collection"><a href="${departmentUrl}">${department}</a> | <a href="${divisionUrl}">${division}</a></dd>

	<div id="images">
		<#list itemAttachments as itemAttachment>
			<#assign uuid = itemAttachment.get('uuid')>
			<#assign full = itemAttachment.get('file')>
			<#if !full?contains("http://") && !full?ends_with(".zip")>
				<a href="/file/${itemUuid}/${itemversion}/${full}" rel="group">
				<img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
			</#if>
		</#list>
	</div>

	<#assign names = xml.get('mods/name/namePart')>
	<#if names != "">
		<dt>Creator(s)</dt>
		<dd>${names}</dd>
	</#if>

    <#assign year = xml.get('mods/origininfo/dateCreatedWrapper/dateCreated')>
	<#if year != "">
		<dt>Year</dt>
		<dd>${year}</dd>
	</#if>

	<#assign courseWorkTypeUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3E${courseWorkType}%3C%2FcourseWorkType%3E%3C%2FcourseWorkWrapper%3E%3Cdepartment%3E{department}%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=&sort=datemodified&dr=AFTER" />
	<dt>Description</dt>
	<dd>
		<#if courseWorkType != "">
			<a href="${courseWorkTypeUrl}">${courseWorkType}</a>
		</#if>
	</dd>
	<dd>
		<#assign assignment = courseWork.get('assignmentDescription')>
		<#if assignment != "">
			 <b>Assignment</b>: ${assignment}
		</#if>
	</dd>

	<#list itemAttachments as itemAttachment>
		<#assign type = itemAttachment.get('@type')>
		<#assign full = itemAttachment.get('file')>
		<#if type == "remote">
			<dd><b>Related link</b>: <a href="${full}">${full}</a></dd>
		</#if>
	</#list>

	<#assign abstract = xml.get('mods/abstract')>
	<#if abstract != "">
		<br>
		<dd>${abstract}</dd>
	</#if>

</dl>
</#if>
</#list>
