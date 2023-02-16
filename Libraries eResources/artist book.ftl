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
<#assign abstract = xml.get('mods/abstract')>

<#if formBroad == "artists' books (books)">
<dl>
<style>
/* undo the terribly annoying display: inline in our theme */
.itemsummary-layout .area p {
    display: block;
}
</style>

<#assign title = xml.get('mods/titleInfo/title')>
<h2 id="title">${title}</h2>

<#assign filenames = xml.get('local/courseWorkWrapper/projectTitle')>
<#assign pages = xml.list('local/courseWorkWrapper/file')?size>
<#-- points to the root of our Internet Archive Bookreader instance -->
<#assign iab = 'https://vault.cca.edu/file/79e553bc-a84c-4610-b6d7-190a90dbb268/1/bookreader.zip/index.html'>
<#assign params = '?title=' + title?url + '&id=' + id?url + '&version=' + version?url + '&filenames=' + filenames?url + '&pages=' + pages + '#page/1/mode/2up'>
<#assign url = iab + params>
<#assign externalUrl = xml.get('mods/relateditem/location')>

<#list attachments as attachment>
    <#assign file = attachment.get('file')>
    <#-- first page of book -->
    <#if file?contains(filenames + '1.JPG')>
        <div class="thumbnail" style="text-align:left"><a href="${url}" target="_blank">
        <img src="/file/${id}/${version}/_THUMBS/${file}_PREVIEW_.jpeg" alt="${title}" style="max-width:250px;height:auto">
        </a></div>
        <#break>
    </#if>
</#list>

<p>
    View an excerpt of this work as <a href="${url}" target="_blank">an interactive flipbook</a>. To see the complete work, visit the library. Find its location <a href="${externalUrl}" target="_blank">here</a>.
</p>

<#if abstract != ''>
    <h3>Description</h3>
    <p><pre>${abstract}</pre></p>
</#if>

<h3>The Artists' Books Collection</h3>
<p>This book is part of the CCA Libraries <cite>Artists' Books Collection</cite>, comprised of approximately 340 unique works. The collection includes works by faculty members, students, alumni, and internationally recognized artists. <a href="https://library.cca.edu/cgi-bin/koha/opac-search.pl?q=an%3A513033">The Artists' Books Collection</a>, housed in the Meyer and Simpson Libraries, was developed to support study and teaching of bookworks as an art form. The collection is non-circulating but browsable within the library by request.</p>
<p>You will find digital excerpts of many artist books <a href="/hierarchy.do?topic=a7b976d5-5316-44da-b06e-7374cd100075&page=1">in VAULT</a>. The online bookreader attempts to capture the diverse and intriguing nature of the book as art form. Enjoy!</p>

<#-- if non-library staff, we remove the attachments section at bottom of pg -->
<#if ! userIsMemberOf('System Administrators') && ! userIsMemberOf('Libraries')>
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

</dl>
</#if>
