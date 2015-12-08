<#assign itemUuid = xml.get('item/@id')>
<#assign itemversion = xml.get('item/@version')>
<#assign title = xml.getAllSubtrees('mods/titleInfo')>
<#assign itemAttachments = xml.getAllSubtrees('item/attachments/attachment')>
<#assign modslevel = xml.getAllSubtrees('mods')>
<#assign local = xml.getAllSubtrees('local')>
<#assign courseWorkWrapper = xml.getAllSubtrees('local/courseWorkWrapper')>

<dl>
<#list title as mods>
	<#assign title = mods.get('title')>
	<h2 id="title">${title}
	</h2>
	<#if title=="Writing & Literature Student First Year Writing Portfolio Guide">
	<dd><strong>First Year Review: Writing Portfolio Specifics</strong></dd>

<dd>Take care in preparing your portfolio, both in what you include and in the cleanliness of its presentation. The portfolio should be no longer than twelve pages maximum (up to 10 pages of creative work, up to 2 pages of a writer's statement).  Details below.</dd>

<dd>Four copies of your portfolio - including your writer´s statement - are due by 5 p.m. on Friday, March 16 in the First Year Office. Please contact Yookyung Bang, Program Manager for Humanities and Sciences if you have questions (ybang@cca.edu). In addition, please send electronic copies of your portfolio to both Yookyung Bang and Matt Shears (mshears@cca.edu).</dd>

<dd>Note: The Review is a requirement for first year students. There are no make-up sessions.</dd>

<dd>Student Presentations must include the following:</dd>

<dd>1. A selection of two to three works (or a total of 10 pages maximum from any Writing and Literature course from the fall 2011 and the spring 2012). We realize that different types of writing (fiction, poetry, drama, the graphic novel, etc.) fill up pages in different ways because of the vagaries of formatting. In the preparation of your portfolio we want to account for that. The general rule of thumb is that you should be presenting the equivalent of ten double-spaced pages of fiction in a normal font. If you have a play where the characters are giving one-word responses to each other, then the ten-page limit might not be appropriate. I am available for consultation should you be unclear about what constitutes an acceptable amount of writing.  Likewise, we ask that you use Microsoft Word for your documents.  Standardizing the format prevents problems later.</dd>

<dd>2. A one to two-page writer´s statement. Aside from your ten portfolio pages, the Humanities and Sciences office requests that you include a one - two page writer´s statement that responds to the following prompts.  We want you to cover these topics, but at the same time we want you to make your statement as artful and fluid as possible.  Consider these a guide for your statement.</dd>

<dd>A.   A critical assessment of where you think you are right now as a writer and how you would like to improve in the future.</dd>
<dd>B.    An assessment of how Writing and Literature courses have affected both your future goals and your present writing, especially the work in your portfolio.</dd>
<dd>C.    An account of assignments or course work that you found especially challenging or helpful to your development.</dd>
<dd>D.    You might also include what course or assignment surprised you the most as well as courses and assignments that you would like to take or feel you need to take in the future.</dd>
<dd>E.    As you reflect on your work in the first year, we are also in the process of reflecting on the program. We are interested in any observations or ideas that you might have about your experience so far and how we can improve the program now and in the future. We consider your insights invaluable.</dd>
	<#else></#if>
</#list>

<#list modslevel as mods>
	<#assign abstract = mods.get('abstract')>
	<#if abstract==""><#else>
		<dd class="abstract">Description: ${abstract}</dd>
	</#if>
</#list>

<#assign dept = xml.getAllSubtrees('local/department')>
<#list local as local>
	<#assign departmentX = local.get('department')>
	<#assign viewLevel = local.get('viewLevel')>
		<dd>Department(s):
		<#list dept as dept>${dept}<#if dept_has_next>, </#if>
		</#list></dd>

		<div id="images">
			<#list itemAttachments as itemAttachment>
				<#assign thumb = itemAttachment.get('thumbnail')>
				<#assign uuid = itemAttachment.get('uuid')>
				<#assign full = itemAttachment.get('file')>
				<#if itemAttachment.get('@type') != 'remote'>
						<a href="/file/${itemUuid}/${itemversion}/${full}" target="_blank">
						<img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
				<#else>
					<a href="${full}">
						<img src="/thumbs/${itemUuid}/${itemversion}/${uuid}">
					</a>
				</#if>
			</#list>
		</div>

	<#list courseWorkWrapper as courseWork>
		<#assign type = courseWork.get('courseWorkType')>
			<dd>This <strong>${type}</strong> is intended for <strong>${viewLevel}</strong> use.</dd>
	</#list>

</#list>
<br/>

<hr>
<h4><i>Click on the thumbnail below to open the document in Google Drive.</i></h4>
