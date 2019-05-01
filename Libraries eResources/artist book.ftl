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
<style>
/* undo the terribly annoying display: inline in our theme */
.itemsummary-layout .area p {
    display: block;
}
</style>

<p><a href="javascript:location = location.origin + "></a></p>

<#assign title = xml.get('mods/titleInfo/title')>
<h2 id="title">${title}</h2>

<#assign filenames = xml.get('local/courseWorkWrapper/projectTitle')>
<#assign pages = xml.list('local/courseWorkWrapper/file')?size>
<#-- points to the root of our Internet Archive Bookreader instance -->
<#assign iab = 'https://libraries.cca.edu/static/bookreader/index.html'>
<#assign params = '?title=' + title?url + '&id=' + id?url + '&version=' + version?url + '&filenames=' + filenames?url + '&pages=' + pages + '#page/1/mode/2up'>
<#assign url = iab + params>
<#assign catalogUrl = xml.get('mods/relateditem/location')>

<#-- show admins links for testing dev versions of bookreader -->
<#if userIsMemberOf('System Administrators')>
    <p>
        <a href="${'http://localhost:8080/' + params}">test on localhost</a> |
        <a href="${iab?replace('.cca.', '-dev.cca.') + params}">test on libraries-dev</a>
    </p>
</#if>

<div class="thumbnail" style="text-align:left">
	<a href="${url}" target="_blank">
		<#list attachments as attachment>
			<#assign file = attachment.get('file')>
			<#-- first page of book -->
			<#if file?contains(filenames + '1.JPG')>
				<img src="/file/${id}/${version}/_THUMBS/${file}_PREVIEW_.jpeg" alt="${title}" style="max-width:250px;height:auto">
			</#if>
		</#list>
	</a>
</div>
<p>
    View an excerpt of this work as <a href="${url}" target="_blank">an interactive flipbook</a>. To see the complete work, visit the library. Find its location <a href="${catalogUrl}" target="_blank">via the library catalog</a>.
</p>

<h3>The Artists' Books Collection</h3>
<p>This book is part of the CCA Libraries <cite>Artists' Books Collection</cite>, comprised of approximately 340 unique works. The collection includes works by faculty members, students, alumni, and internationally recognized artists. <a href="https://library.cca.edu/cgi-bin/koha/opac-search.pl?q=(su:%7BArtists%27%20books%20collection.%7D)">The Artists' Books Collection</a>, housed in the Meyer and Simpson Libraries, was developed to support study and teaching of bookworks as an art form. The collection is non-circulating but browsable within the library by request.</p>
<p>You will find digital excerpts of many artist books <a href="/hierarchy.do?topic=a7b976d5-5316-44da-b06e-7374cd100075&page=1">in VAULT</a>. The online bookreader attempts to capture the diverse and intriguing nature of the book as art form. Enjoy!</p>

<#-- if non-library staff, we remove the attachments section at bottom of pg -->
<#if ! userIsMemberOf('System Administrators') && ! userIsMemberOf('Libraries') && ! userIsMemberOf('Library Contributors') && ! userIsMemberOf('Library Workstudy') && ! userIsMemberOf('Library Administrator')>
    <script>
    $(function{}($('#sc_attachments_div, #sc_attachments_extras, .area h3:last-of-type').remove()))
    </script>
    <style>
    #sc_attachments_div,
    #sc_attachments_extras,
    .area h3:last-of-type {
        display: none;
    }
    </style>
</#if>

</dl></#if>
