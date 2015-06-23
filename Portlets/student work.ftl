<#-- no built-in random number facility, use current time
taken from: http://freestyle-developments.co.uk/blog/?p=327 -->
<#function rand min max>
  <#local now = .now?long?c />
  <#local randomNum = _rand + ("0." + now?substring(now?length-1) + now?substring(now?length-2))?number />
  <#if (randomNum > 1)>
    <#assign _rand = randomNum % 1 />
  <#else>
    <#assign _rand = randomNum />
  </#if>
  <#return (min + ((max - min) * _rand))?round />
</#function>
<#assign _rand = 0.36 />

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
<#--
advancedSearch parameters are:
    query — free text query
    where — xpath/SQL clause
    onlyLive — boolean for whether to only return live items
    orderType — 0: Ranking, 1: Date Modified, 2: Name
    reverse — boolean for reverse order
    offset — first result index
    maxResults — integer number of results to get
-->
<#assign search = utils.searchAdvanced('', "/xml/local/rating like 'High'", true, order, reverse, offset, 40)>
<#assign results = search.getResults()>

<div class="clearfix">
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
    <#if thumb != "">
        <a href="${url}" title="${name}"><img src="${thumbUrl}" onerror="$(this).css('display', 'none')" /></a>
    </#if>
</#list>
</div>
