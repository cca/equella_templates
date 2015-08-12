<#assign id = xml.get('item/@id')>
<#assign version = xml.get('item/@version')>
<#assign attachments = xml.getAllSubtrees('item/attachments/attachment')>
<#assign parts = xml.list('mods/part/number')>
<#assign flipbookFiles = xml.list('mods/part/numberB')>
<#assign configID = xml.get('mods/identifier')>

<dl class="clearfix">
<#assign title = xml.get('mods/titleInfo/title')>
<h2 id="title">${title}</h2>

<#assign filenames = xml.get('local/courseWorkWrapper/projectTitle')>
<#if filenames != "">
	<#assign pages = xml.list('local/courseWorkWrapper/file')?size>
	<#-- points to the root of our Internet Archive Bookreader instance -->
	<#assign iab = 'http://libraries.cca.edu/bookreader/'>
	<h3>View Book</h3>
	<#-- Bookreader URL — it parses the values passed to it -->
	<#assign url = iab + '?title=' + title?url + '&id=' + id?url + '&version=' + version?url + '&filenames=' + filenames?url + '&pages=' + pages>
	<div class="thumbnail" style="text-align:left">
		<a href="${url}" target="_blank">
			<#list attachments as attachment>
				<#assign file = attachment.get('file')>
				<#-- first page of book -->
				<#if file?contains(filenames + '1.JPG')>
					<img src="/file/${id}/${version}/${file}" alt="${title}" style="max-width:250px;height:auto">
				</#if>
			</#list>
		</a>
		<#-- break needed b/c otherwise caption is awkwardly positioned -->
		<br>
		<strong><a class="caption" href="${url}" target="_blank">View this title</a> as an interactive flipbook.</strong>
		<br><br>
	</div>
</#if>

<#-- @TODO still undecided whether & how we want to show page thumbnails -->
<#if parts?size != 0>
	<ul class="thumbnails">
	<#list attachments as attachment>
		<#assign full = attachment.get('file')>
		<#assign uuid = attachment.get('uuid')>
		<#list parts as part>
			<#if part == uuid>
				<li class="thumbnail">
					<a href="/file/${id}/${version}/${full}">
					<img src="/thumbs/${id}/${version}/${uuid}"/></a>
				</li>
			</#if>
		</#list>
	</#list>
	</ul>
</#if>

<#list xml.getAllSubtrees('mods/relateditem') as relateditem>
    <#assign title = relateditem.get('title')>
    <#assign location = relateditem.get('location')>
    <#assign issuuLink = relateditem.get('note')>
    <#assign @type = relateditem.get('@type')>
    <#if issuuLink != "">
        <div data-configid="${configID}" style="width: 525px; height: 525px;" class="issuuembed"></div>
        <script src="//e.issuu.com/embed.js" async="true"></script>
    </#if>

    <#if title != "" && location != "">
        <#if relateditem_index == 0>
            <dt>Related item</dt>
        </#if>
        <dd>
            <#if @type == "isReferencedBy">
                Referenced by:
            </#if>
            <em>
	            <#if location != "" && location != "http://library.cca.edu/record=b">
	                <a href="${location}">${title}</a>
	            <#else>
	                ${title}
	            </#if>
            </em>
        </dd>
    </#if>
</#list>
</dl>
