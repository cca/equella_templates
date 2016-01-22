<#assign itemUuid = xml.get('item/@id')>
<#assign itemversion = xml.get('item/@version')>
<#assign itemAttachments = xml.getAllSubtrees('item/attachments/attachment')>
<#assign name = xml.getAllSubtrees('mods/name')>
<#assign modslevel = xml.getAllSubtrees('mods')>
<#assign origininfo = xml.getAllSubtrees('mods/origininfo')>
<#assign subject = xml.getAllSubtrees('mods/subject')>
<#assign relateditem = xml.getAllSubtrees('mods/relateditem')>
<#assign local = xml.getAllSubtrees('local')>

<div id="images">
<#list itemAttachments as itemAttachment>
	<#assign full = itemAttachment.get('file')>
	<#assign uuid = itemAttachment.get('uuid')>
	<a href="/file/${itemUuid}/${itemversion}/${full}">
	<img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
</#list>
</div>

<dt>Videographer</dt>
<#list name as mods>
	<#assign name = mods.get('namePart')>
	<#assign department = mods.get('department')>
	<#assign constituent = mods.get('constituent')>
	<#assign affiliation = mods.get('affiliation')>
	<#assign nameUrl = "/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3Cname%3E%3CnamePart%3E${name}%3C%2FnamePart%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=P04c5d28c-713c-37fe-5e33-6c0ee78651f0&q=&sort=rank&dr=AFTER" />
	<#assign departmentUrl = "/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3Cname%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=P04c5d28c-713c-37fe-5e33-6c0ee78651f0&q=&sort=rank&dr=AFTER" />
	<#assign constituentUrl = "/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3Cname%3E%3Cconstituent%3E${constituent}%3C%2Fconstituent%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=P04c5d28c-713c-37fe-5e33-6c0ee78651f0&q=&sort=rank&dr=AFTER" />
	<dd><a href="${nameUrl}">${name}</a></dd>
	<span id="namestuff"><a href="${departmentUrl}">${department}</a>
	<#if (department=="" && constituent=="")>
	<#else>- <a href="${constituentUrl}">${constituent}</a></#if>
	<#if (affiliation=="")>
	<#else>- ${affiliation}</#if></span></dd>
</#list>

<#list modslevel as mods>
	<#assign abstract = mods.get('abstract')>
	<#assign toc = mods.get('tableOfContents')>
	<#if abstract==""><#else>
	<dt>Description</dt>
	<dd class="abstract">${abstract}</dd></#if>
</#list>

<div style="clear:both;"></div>
<dt>Subject(s)</dt>
<#list subject as mods>
	<#assign topic = mods.get('topic')>
	<#assign name = mods.get('name')>
	<#if topic==""><#else><dd class="subject">Topic: ${topic}</dd></#if>
	<#assign nameUrl = "/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3Csubject%3E%3Cname%3E${name}%3C%2Fname%3E%3C%2Fsubject%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=P04c5d28c-713c-37fe-5e33-6c0ee78651f0&q=&sort=rank&dr=AFTER" />
	<#if name==""><#else><dd class="subject">Name: <a href="${nameUrl}">${name}</a></dd></#if>
</#list>

<#list modslevel as mods>
	<#assign photoClassification = mods.get('photoClassification')>
		<#assign photoClassificationUrl = "/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3CphotoClassification%3E${photoClassification}%3C%2FphotoClassification%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=P04c5d28c-713c-37fe-5e33-6c0ee78651f0&q=&sort=rank&dr=AFTER" />
	<#if photoClassification==""><#else><dd class="subject">CCA subject: <a href="${photoClassificationUrl}">${photoClassification}</a></dd></#if>
</#list>
<div style="clear:both;"></div>

<#list relateditem as mods>
	<#assign title = mods.get('title')>
	<#assign location = mods.get('location')>
	<#assign note = mods.get('note')>
	<#assign @type = mods.get('@type')>
	<#if (title == "" && location== "" && note== "")>
	<#else><dt>Related publication(s)</dt>
	<dd>
	<em>${title}</em>
	</dd>
	<#if location==""><#else><dd>Location: ${location}</dd>
	</#if><#if note==""><#else><dd>Note: ${note}</dd></#if></#if>
</#list>
