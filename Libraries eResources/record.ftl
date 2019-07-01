<#assign id = xml.get('item/@id')>
<#assign version = xml.get('item/@version')>
<#assign attachments = xml.getAllSubtrees('item/attachments/attachment')>
<#assign parts = xml.list('mods/part/number')>
<#assign configID = xml.get('mods/identifier')>
<#assign formBroad = xml.get('mods/physicalDescription/formBroad')>
<#assign abstract = xml.get('mods/abstract')>

<#if formBroad == ""><dl class="clearfix">

<#assign title = xml.get('mods/titleInfo/title')>
<h2 id="title">${title}</h2>

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
    <#assign location = relateditem.get('location')>
    <#assign issuuLink = relateditem.get('note')>
    <#if issuuLink != "">
        <div data-configid="${configID}" style="width: 525px; height: 525px;" class="issuuembed"></div>
        <script src="//e.issuu.com/embed.js" async="true"></script>
    </#if>

	<#if location != "">
        <#if relateditem_index == 0>
            <dt>Library Catalog Link</dt>
        </#if>
        <dd>
            <em>
	            <#if location != "" && location != "http://library.cca.edu/record=b">
	                <a href="${location}">${location}</a>
	            </#if>
            </em>
        </dd>
    </#if>
</#list>

<#if abstract != ''>
	<h3>Description</h3>
    <p><pre>${abstract}</pre></p>
</#if>

</dl></#if>
