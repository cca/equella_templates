<#-- NOTE in the portlets admin, load the following CSS:
- /file/0be6649f-15fa-45da-80ac-1a9c539a9418/2/dashboard-student-work.min.css
- /file/3c22fa1f-f837-45af-a675-115894f6b1ae/2/justifiedGallery.min(2).css

also load the following JS under "Client-side on-ready script":
- /file/3c22fa1f-f837-45af-a675-115894f6b1ae/2/jquery.justifiedGallery.min.js
- /file/9e9a26b8-5d55-4d11-82f6-0f6e901c65a8/3/cca-home.min.js
-->

<#-- check user role, passing to client side, used in tour.js -->
<#if user.hasRole('490b1b93-10cd-b8fa-3291-93c357efe57b')>
    <#assign role = 'faculty'>
<#elseif user.hasRole('c8038af0-fa3f-9a70-e5e1-3f768972203a')>
    <#assign role = 'staff'>
<#elseif user.hasRole('89ea364f-066e-1a3f-f70e-4b29f08e8448')>
    <#assign role = 'student'>
<#else>
    <#assign role = 'public'>
</#if>
<script>window._ccaRole = '${role}'</script>

<#-- no built-in random number facility, use current time
taken from: http://freestyle-developments.co.uk/blog/?p=327 -->
<#function rand min max>
  <#local now = .now?long?c>
  <#local randomNum = _rand + ("0." + now?substring(now?length-1) + now?substring(now?length-2))?number>
  <#if (randomNum > 1)>
    <#assign _rand = randomNum % 1>
  <#else>
    <#assign _rand = randomNum>
  </#if>
  <#return (min + ((max - min) * _rand))?round>
</#function>
<#assign _rand = 0.36>

<#-- retrieve pseudo-random results by randomizing a few of the advanced
search parameters: order of results, reverse, & offset -->
<#assign query = ''>
<#-- retrieve highly rated student work & anything from Undergrad Exhibitions
note that few items (≈400 as of 7/8/15) have a high rating & more are FYP -->
<#assign where = "/xml/local/rating IS 'High' OR /xml/local/department IS 'Undergraduate Exhibitions'">
<#assign onlyLive = true>
<#assign order = rand(0, 2)>
<#assign reverse = true>
<#assign reverseNum = rand(0, 1)>
<#if reverseNum = 1>
    <#assign reverse = false>
</#if>
<#assign offset = rand(0, 20)>
<#assign maxResults = 50>
<#-- hidden debugging information -->
<div id="sw-debug" style="display:none">
order: ${order}<br>
<#-- have to explicitly cast booleans to strings or error occurs, well done Freemarker -->
reverse: ${reverse?string}<br>
offset: ${offset}<br>
<#-- order isn't implemented properly here, the search API takes entirely different
set of options (reverse, modified, name, rating instead of their enum integers) -->
<a href="/api/search/?where=${where}&order=${order}&reverse=${reverse?string}&start=${offset}&length=${maxResults}">search results via API</a>
</div>
<#assign search = utils.searchAdvanced(query, where, onlyLive, order, reverse, offset, maxResults)>
<#assign results = search.getResults()>

<#-- wraps whole section -->
<div class="clearfix">
    <div id="mainTabs">
        <a data-target="#studentWork" class="tab active">Student Work</a>
        <a data-target="#libraryCollections" class="tab">Library Collections</a>
        <a data-target="#campusPlanning" class="tab">Campus Planning: Spatial Benchmarking</a>
        <a href="/access/searching.do?in=all&type=gallery" class="tab link">Browse All Collections</a>
    </div>

    <div id="studentWork" style="display:none">
    <#-- this "count" check limits the display to 20 images, works around the fact
    that the number of results with thumbnails can be *highly* variable
    (from 2 to 50 in tests!) making the display erratic -->
    <#assign count = 0>
    <#list results as item>
        <#if count = 20>
            <#break>
        </#if>
        <#-- item information -->
        <#assign name = item.getName()>
        <#assign itemUuid = item.getUuid()>
        <#assign version = item.getVersion()>
        <#assign url = '/items/' + itemUuid + '/' + version + '/'>
        <#assign thumbUrl = '/thumbs/' + itemUuid + '/' + version + '/?gallery=true'>

        <#-- check if the first attachment is an image
        this avoids mime types for which we have a generic icon thumbnail
        or items lacking an attachment -->
        <#assign thumb = item.getXml().get('item/attachments/attachment/thumbnail')>
        <#assign filename = item.getXml().get('item/attachments/attachment/file')>
        <#-- filename check is to prevent remote/link attachments -->
        <#if thumb != "" && ! filename?starts_with('http')>
            <#assign mimetype = mime.getMimeTypeForFilename(filename).getType()>
            <#if mimetype?substring(0, 5) == 'image'>
                <#assign count = count + 1>
                <a href="${url}" title="${name}"><img src="${thumbUrl}" /></a>
            </#if>
        </#if>
    </#list>
    </div>

    <#--
        Library Collections tab

        most of the searchAdvanced parameters inherit values from above
        we only need to redefine the "where" value, pointing to Libraries collection

        should we restrict to images? add below to where query
        /xml/mods/physicalDescription/internetMediaType LIKE 'image/*'

        I also attempted /xml/collection IS 'Libraries' to limit to Libraries coll
        but that query returns 0 results for some reason
    -->
    <#assign where = "/xml/item/@itemdefid IS '6b755832-4070-73d2-77b3-3febcc1f5fad'">
    <#assign search = utils.searchAdvanced(query, where, onlyLive, order, reverse, offset, maxResults)>
    <#assign results = search.getResults()>

    <div id="libraryCollections" style="display:none">
        <#assign count = 0>
        <#list results as item>
            <#if count = 20>
                <#break>
            </#if>
            <#-- item information -->
            <#assign name = item.getName()>
            <#assign itemUuid = item.getUuid()>
            <#assign version = item.getVersion()>
            <#assign url = '/items/' + itemUuid + '/' + version + '/'>
            <#assign thumbUrl = '/thumbs/' + itemUuid + '/' + version + '/?gallery=true'>

            <#assign thumb = item.getXml().get('item/attachments/attachment/thumbnail')>
            <#assign filename = item.getXml().get('item/attachments/attachment/file')>
            <#if thumb != "" && ! filename?starts_with('http')>
                <#assign mimetype = mime.getMimeTypeForFilename(filename).getType()>
                <#if mimetype?substring(0, 5) == 'image'>
                    <#assign count = count + 1>
                    <a href="${url}" title="${name}"><img src="${thumbUrl}" /></a>
                </#if>
            </#if>
        </#list>
    </div>

    <#--
        Campus Planning tab

        again, searchAdvanced parameters inherit values from 1st usage
        we only need to redefine the "where" value, pointing to CP collection
    -->
    <#assign where = "/xml/item/@itemdefid IS 'f75326ab-977c-4873-8987-eaa419ecb773'">
    <#assign search = utils.searchAdvanced(query, where, onlyLive, order, reverse, offset, maxResults)>
    <#assign results = search.getResults()>

    <div id="campusPlanning" style="display:none">
        <#assign count = 0>
        <#list results as item>
            <#-- CP items tend to have wider thumbnails for whatever reason
            so student-work-home.js sets their height to 3/4ths (67.5px) others
            thus here we insert more results from the search -->
            <#if count = 28>
                <#break>
            </#if>
            <#-- item information -->
            <#assign name = item.getName()>
            <#assign itemUuid = item.getUuid()>
            <#assign version = item.getVersion()>
            <#assign url = '/items/' + itemUuid + '/' + version + '/'>
            <#assign thumbUrl = '/thumbs/' + itemUuid + '/' + version + '/?gallery=true'>

            <#assign thumb = item.getXml().get('item/attachments/attachment/thumbnail')>
            <#assign filename = item.getXml().get('item/attachments/attachment/file')>
            <#if thumb != "" && ! filename?starts_with('http')>
                <#assign mimetype = mime.getMimeTypeForFilename(filename).getType()>
                <#if mimetype?substring(0, 5) == 'image'>
                    <#assign count = count + 1>
                    <a href="${url}" title="${name}"><img src="${thumbUrl}" /></a>
                </#if>
            </#if>
        </#list>
    </div> <#-- end campus planning -->

</div> <#-- end wrapper -->
