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

<#--
used to create pseudo-random results by randomizing a few of the advanced
search parameters: order of results, reverse, and offset
-->
<#assign order = rand(0, 2)>
<#assign reverse = true>
<#assign reverseNum = rand(0, 1)>
<#if reverseNum = 1>
    <#assign reverse = false>
</#if>
<#assign offset = rand(0, 10)>
<#assign length = 40>
<#-- hidden debugging information -->
<div id="sw-debug" style="display:none">
order: ${order}<br>
reverse: ${reverse?string}<br>
offset: ${offset}<br>
<a href="https://vault.cca.edu/api/search/?where=/xml/local/rating like 'High'&order=${order}&reverse=${reverse?string}&start=${offset}&length=${length}">search results via API</a>
</div>
<#--
advancedSearch parameters are:
    query — free text query
    where — xpath/SQL clause
    onlyLive — boolean for whether to only return live items
    orderType — 0: Ranking, 1: Date Modified, 2: Name
    reverse — boolean for reverse order
    offset — first result index
    maxResults — integer number of results to get

    @TODO pull from UG Exhibits collection, too
-->
<#assign search = utils.searchAdvanced('', "/xml/local/rating like 'High'", true, order, reverse, offset, length)>
<#assign results = search.getResults()>

<div id="studentWork">
<#list results as item>
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
            <a href="${url}" title="${name}"><img src="${thumbUrl}" onerror="$(this).parent().remove()" /></a>
        </#if>
    </#if>
</#list>
</div>
