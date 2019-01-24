<#assign itemUuid = xml.get('item/@id')>
<#assign itemversion = xml.get('item/@version')>
<#assign itemAttachments = xml.getAllSubtrees('item/attachments/attachment')>
<#assign name = xml.getAllSubtrees('mods/name')>
<#assign titleInfo = xml.getAllSubtrees('mods/titleInfo')>
<#assign modslevel = xml.getAllSubtrees('mods')>
<#assign date = xml.getAllSubtrees('mods/origininfo/dateCreatedWrapper')>
<#assign origin = xml.getAllSubtrees('mods/origininfo')>
<#assign local = xml.getAllSubtrees('local')>
<#assign communications = xml.getAllSubtrees('local/communicationsWrapper')>
<#assign jpgWrapper = xml.getAllSubtrees('local/communicationsWrapper/filesWrapper/jpgWrapper')>
<#assign tiffWrapper = xml.getAllSubtrees('local/communicationsWrapper/filesWrapper/tiffWrapper')>


<dl>

<#list titleInfo as titleInfo>
	<#assign title = titleInfo.get('title')>
		<h2 id="title"><em>${title}</em></h2>
</#list>

<#list attachments.list() as att>
	<#attempt>
		<#assign mimeType = mime.getMimeTypeForFilename(att.getFilename()).getType()>
		<#if att.getType() == "FILE" && mimeType == "image/jpeg" || mimeType == "image/png">
	        <img src="${utils.getItemUrl(currentItem) + att.getFilename()}" width="450" />
	    </#if>
	<#recover>
		<#-- just skip — if we don't know the mime type it's not an image -->
	</#attempt>
</#list>

<#list communications as communications>
	<#assign submissionType = communications.get('submissionType')>
	<#assign issuuLink = communications.get('note')>
	<#if submissionType == "press image">
		<#list itemAttachments as itemAttachment>
			<#assign full = itemAttachment.get('file')>
			<#assign uuid = itemAttachment.get('uuid')>
			<#list jpgWrapper as jpgWrapper>
				<#assign jpgFile = jpgWrapper.get('jpgFile')>
				<#list tiffWrapper as tiffWrapper>
					<#assign tiffFile = tiffWrapper.get('tiffFile')>
					<#if jpgFile == uuid>
						<div class='image-studentWork'>

						<p class='photoImagelist'>
						<a href="/file/${itemUuid}/${itemversion}/${full}" target="_blank">JPG</a>
					<#elseif tiffFile == uuid>
						/ <a href="/file/${itemUuid}/${itemversion}/${full}" target="_blank">TIFF</a>
						</p>
						</div>
					</#if>
				</#list>
			</#list>
		</#list>
	<#elseif (submissionType=="document") || ((submissionType=="publication") && (issuuLink==""))>
		<div id="images">
		<#list itemAttachments as itemAttachment>
			<#assign full = itemAttachment.get('file')>
			<#assign uuid = itemAttachment.get('uuid')>
			<a href="/file/${itemUuid}/${itemversion}/${full}" target="_blank">
			<img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
		</#list>
		</div>
	<#elseif (submissionType=="publication") && (issuuLink!="")>
		${issuuLink}
	</#if>
</#list>
<div style="clear:both;"></div>

<#assign designer = xml.getAllSubtrees('local/communicationsWrapper/designer')>
<#assign photographer = xml.getAllSubtrees('local/communicationsWrapper/photographer')>
<#list communications as communications>
	<#assign designerx = communications.get('designer')>
	<#assign photographerx = communications.get('photographer')>
	<#assign submissionType = communications.get('submissionType')>
	<#-- <dd>${photographer} -->
	<#assign photographerUrl = "" />
	<#-- <dd>${designer} -->
	<#assign designerUrl = "" />
	<#-- <dd>${submissionType} -->
	<#assign submissionTypeUrl = "" />
	<dd><strong><em>Type of resource:</em></strong> ${submissionType}</dd>

	<#if (submissionType=="publication")>
		<#if (designerx=="")><#else>
		<dd><strong><em>Designers</em></strong></dd>
		<#list designer as designer>
			<#if designer==""><#else>
				<dd>${designer}</dd>
			</#if>
		</#list>
		</#if>
		<#if (photographerx=="")><#else>
			<br /><dd><strong><em>Photo credits</em></strong></dd>
			<#list photographer as photographer>
				<#if photographer==""><#else>
					<dd>${photographer}</dd>
				</#if>
			</#list>
		</#if>
	<#elseif submissionType=="press image">
		<#if (photographerx=="")><#else>
			<dd><strong><em>Photographer:</em></strong>
			<#list photographer as photographer>
				<#if photographer==""><#else>
					${photographer}<#if photographer_has_next>, </#if>
				</#if>
			</#list>
			</dd>
		</#if>
	</#if>

	<#list modslevel as mods>
		<#assign abstract = mods.get('abstract')>
		<#assign toc = mods.get('tableOfContents')>
		<#if abstract==""><#else>
			<dd>Description: <pre>${abstract}</pre></dd>
		</#if>
	</#list>

</#list>
