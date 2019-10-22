<#assign itemUuid = xml.get('item/@id')>
<#assign itemversion = xml.get('item/@version')>
<#assign itemAttachments = xml.getAllSubtrees('item/attachments/attachment')>
<#assign titleInfo = xml.getAllSubtrees('mods/titleInfo')>
<#assign communications = xml.getAllSubtrees('local/communicationsWrapper')>
<#assign jpgWrapper = xml.getAllSubtrees('local/communicationsWrapper/filesWrapper/jpgWrapper')>
<#assign tiffWrapper = xml.getAllSubtrees('local/communicationsWrapper/filesWrapper/tiffWrapper')>

<dl>
<#list titleInfo as titleInfo>
	<h2 id="title"><em>${titleInfo.get('title')}</em></h2>
</#list>

<#list attachments.list() as att>
	<#-- sometimes users upload a file of unknown mime type e.g.
	https://vault.cca.edu/items/c2ea9f23-9484-4038-99b7-31f14d6854cd/1/
	!"" means mimeType will default to empty string in these instances
	otherwise a "FreeMarker template error: The following has evaluated to null
	or missing" is thrown, even inside an attempt/recover block -->
		<#assign mimeType = mime.getMimeTypeForFilename(att.getFilename())!"">
		<#if att.getType() == "FILE" && mimeType != "" && mimeType.getType()?starts_with("image/")>
	        <img src="${utils.getItemUrl(currentItem) + att.getFilename()}" width="450" />
	    </#if>
</#list>

<#list communications as communications>
	<#assign submissionType = communications.get('submissionType')>
	<#assign issuuEmbed = communications.get('note')>
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
	<#elseif (submissionType == "document" || (submissionType == "publication" && issuuEmbed == ""))>
		<div id="images">
		<#list itemAttachments as itemAttachment>
			<#assign full = itemAttachment.get('file')>
			<#assign uuid = itemAttachment.get('uuid')>
			<a href="/file/${itemUuid}/${itemversion}/${full}" target="_blank">
			<img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
		</#list>
		</div>
	<#elseif (submissionType == "publication" && issuuEmbed != "")>
		${issuuEmbed?replace("<iframe", "<iframe style='width:100%;height:500px'")}
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

	<#assign abstract = xml.get('mods/abstract')>
	<#if abstract != "">
		<dd><strong>Description</strong>: <pre>${abstract}</pre></dd>
	</#if>

</#list>
</dl>
