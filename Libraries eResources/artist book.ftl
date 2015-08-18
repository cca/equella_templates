<#function userIsMemberOf groupName>
  <#list user.getGroups() as group>
    <#if group.getName() == groupName>
      <#return true>
    </#if>
  </#list>
  <#return false>
</#function>

<#assign id = xml.get('item/@id')>
<#assign version = xml.get('item/@version')>
<#assign attachments = xml.getAllSubtrees('item/attachments/attachment')>
<#assign formBroad = xml.get('mods/physicalDescription/formBroad')>

<#if formBroad == "artists' books (books)"><dl>

<#assign title = xml.get('mods/titleInfo/title')>
<h2 id="title">${title}</h2>

<#assign filenames = xml.get('local/courseWorkWrapper/projectTitle')>
<#assign pages = xml.list('local/courseWorkWrapper/file')?size>
<#-- points to the root of our Internet Archive Bookreader instance -->
<#assign iab = 'http://libraries.cca.edu/bookreader/'>
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
	<strong><a class="caption" href="${url}" target="_blank">View this title as an interactive flipbook.</a></strong>
	<br><br>
</div>

<#list xml.getAllSubtrees('mods/relateditem') as relateditem>
    <#assign location = relateditem.get('location')>
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

<#-- if non-library staff, we remove the attachments section at bottom of pg -->
<#if ! userIsMemberOf('System Administrators') && ! userIsMemberOf('Libraries') && ! userIsMemberOf('Library Contributors') && ! userIsMemberOf('Library Workstudy') && ! userIsMemberOf('Library Administrator')>
    <script>
    $('#sc_attachments_div, #extras, .area h3:last-child').remove()
    </script>
    <style>
    #sc_attachments_div,
    #extras,
    .area h3:last-child {
        display: none;
    }
    </style>
</#if>

</dl></#if>
