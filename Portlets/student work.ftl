<#-- NOTE in the portlets admin, load the Masonry JS library
under "Client-side on-ready script" external JS files -->

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
<a href="https://vault.cca.edu/api/search/?where=${where}&order=${order}&reverse=${reverse?string}&start=${offset}&length=${maxResults}">search results via API</a>
</div>
<#assign search = utils.searchAdvanced(query, where, onlyLive, order, reverse, offset, maxResults)>
<#assign results = search.getResults()>

<div class="clearfix">
<h3>Student Work</h3>
<div id="studentWork">
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
            <#-- onerror attribute here removes images that 404
            @TODO is that still necessary with the conditions above? -->
            <#assign count = count + 1>
            <a href="${url}" title="${name}"><img src="${thumbUrl}" onerror="$(this).parent().remove()" /></a>
        </#if>
    </#if>
</#list>
</div>
</div>
