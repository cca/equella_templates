<#assign id = xml.get('item/@id')>
<#assign version = xml.get('item/@version')>
<#assign attachments = xml.getAllSubtrees('item/attachments/attachment')>
<#assign parts = xml.getAllSubtrees('mods/part')>
<#assign flipbookFiles = xml.list('mods/part/numberB')>
<#assign configID = xml.get('mods/identifier')>

<dl class="clearfix">
<#assign title = xml.get('mods/titleInfo/title')>
<h2 id="title">${title}</h2>

<#list flipbookFiles as flipbookFile>
	<#list attachments as attachment>
		<#assign file = attachment.get('file')>
		<#if attachment.get('uuid') == flipbookFile && file?ends_with('.html')>
			<h3>View Book</h3>
			<#-- we really want to call attention to this -->
			<dd class="alert"><strong>
				<a href="/file/${id}/${version}/${file}" target="_blank">View this title</a> as an interactive flipbook.
			</strong></dd>
		</#if>
	</#list>
</#list>

<#assign filenames = xml.get('local/courseWorkWrapper/projectTitle')>
<#if filenames != "">
	<#assign pages = xml.list('local/courseWorkWrapper/file')?size>
	<h3>View Book</h3>
	<#-- Bookreader URL — it parses the values passed to it -->
	<#assign url = 'http://vm-lib-www-dev-01/bookreader/?title=' + title?url + '&id=' + id?url + '&version=' + version?url + '&filenames=' + filenames?url + '&pages=' + pages>
	<#-- we really want to call attention to this -->
	<dd class="alert"><strong>
		<a href="${url}" target="_blank">View this title</a> as an interactive flipbook.
	</strong></dd>
</#if>

<#list xml.getAllSubtrees('mods/relateditem') as relateditem>
    <#assign title = relateditem.get('title')>
    <#assign location = relateditem.get('location')>
    <#assign issuuLink = relateditem.get('note')>
    <#assign @type = relateditem.get('@type')>
    <#if issuuLink == "">
        <ul class="thumbnails">
        <#list attachments as attachment>
            <#assign full = attachment.get('file')>
            <#assign uuid = attachment.get('uuid')>
            <#list parts as part>
                <#assign parttitle = part.get('title')>
                <#assign partextent = part.get('extent')>
                <#assign partnumber = part.get('number')>
                <#if partnumber == uuid>
					<li class="thumbnail">
						<a href="/file/${id}/${version}/${full}">
						<img src="/thumbs/${id}/${version}/${uuid}"/></a>
                    <#if parttitle != "" || partextent != "">
                        <p class="caption">
                            <#if parttitle != ""><em>${parttitle}</em><br></#if>
                            <#if partextent != ""> ${partextent}</#if>
                        </p>
                    </#if>
					</li>
                </#if>
            </#list>
        </#list>
		</ul>
    <#elseif issuuLink != "">
        <div data-configid="${configID}" style="width: 525px; height: 525px;" class="issuuembed"></div>
        <script type="text/javascript" src="//e.issuu.com/embed.js" async="true"></script>
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
