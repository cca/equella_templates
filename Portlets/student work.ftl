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
<a href="/api/search/?where=${where}&order=${order}&reverse=${reverse?string}&start=${offset}&length=${maxResults}">search results via API</a>
</div>
<#assign search = utils.searchAdvanced(query, where, onlyLive, order, reverse, offset, maxResults)>
<#assign results = search.getResults()>

<#-- wraps whole section -->
<div class="clearfix">
    <div id="mainTabs">
        <div data-target="#studentWork" class="mainTab active">Student Work</div>
        <div data-target="#libraryCollections" class="mainTab">Library Collections</div>
        <div data-target="#campusPlanning" class="mainTab" id="campBtn">Campus Planning: Spatial Benchmarking</div>
    </div>

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

    <#-- library collection pre-selected images -->
    <div id="libraryCollections" style="display:none">
        <a href="/items/576d5b21-e96b-4c24-b8fc-5b9f80fe2998/1/">
            <img src="/file/576d5b21-e96b-4c24-b8fc-5b9f80fe2998/1/13051706PS.jpg">
        </a>
        <a href="/items/aea1a5b3-439c-40b7-9108-201177493e57/1/">
            <img src="/file/aea1a5b3-439c-40b7-9108-201177493e57/1/13051701PS.jpg">
        </a>
        <a href="/items/5f86f540-3804-ada6-d23d-deba76285264/1/">
            <img src="/file/5f86f540-3804-ada6-d23d-deba76285264/1/06050806PR.jpg">
        </a>
        <a href="/items/1119c6ff-945b-49f2-a59a-aaf1906daf1d/1/">
            <img src="/file/1119c6ff-945b-49f2-a59a-aaf1906daf1d/1/13051705PS.jpg">
        </a>
        <a href="/items/64c18395-b855-4bca-a56a-39e3b9dceb6c/1/">
            <img src="/file/64c18395-b855-4bca-a56a-39e3b9dceb6c/1/06050811PS.jpg">
        </a>
        <a href="/items/e8c45774-fe75-1d59-5fed-e61e96690231/1/">
            <img src="/file/e8c45774-fe75-1d59-5fed-e61e96690231/1/05122214CP.jpg">
        </a>
        <a href="/items/89207d4c-c06f-871e-21c5-b09505ef2f04/1/">
            <img src="/file/89207d4c-c06f-871e-21c5-b09505ef2f04/1/06050801PR.jpg">
        </a>
          <a href="/items/cc55c77f-74d6-5b36-c250-bee1ffd99b4b/1/">
            <img src="/file/cc55c77f-74d6-5b36-c250-bee1ffd99b4b/1/06050812PR.jpg">
        </a>
        <a href="/items/ff95c836-1236-ed70-1608-12f426442fe6/1/">
            <img src="/file/ff95c836-1236-ed70-1608-12f426442fe6/1/06050802PR.jpg">
        </a>
        <a href="/items/576f4150-48d2-3fac-7e65-b81eb9287f36/1/">
            <img src="/file/576f4150-48d2-3fac-7e65-b81eb9287f36/1/06101202PR.jpg">
        </a>
        <a href="/items/3b20fff3-0974-7958-ef34-47feba6418e8/1/">
            <img src="/file/3b20fff3-0974-7958-ef34-47feba6418e8/1/07011307WA.jpg">
        </a>
        <a href="/items/415ee806-36ce-8ff2-147d-9fbc4de3f87e/1/">
            <img src="/file/415ee806-36ce-8ff2-147d-9fbc4de3f87e/1/06052201PS.jpg">
        </a>
        <a href="/items/1a227ece-b336-95df-9fae-b5d318949f8c/1/">
            <img src="/file/1a227ece-b336-95df-9fae-b5d318949f8c/1/06110103BE.jpg">
        </a>
        <a href="/items/e6490676-0020-3a29-85b6-7a41352a383b/1/">
            <img src="/file/e6490676-0020-3a29-85b6-7a41352a383b/1/05122201BE.jpg">
        </a>
    </div> <#-- end library collections -->

    <#-- campus planning pre-selected images -->
    <div id="campusPlanning" style="display:none">
        <a href="/items/3cf238ed-af42-4208-ad04-6ed91e67fedd/1/">
            <img src="/file/3cf238ed-af42-4208-ad04-6ed91e67fedd/1/SFO%20T2%205.jpg">
        </a>
        <a href="/items/3cf238ed-af42-4208-ad04-6ed91e67fedd/1/">
            <img src="/file/3cf238ed-af42-4208-ad04-6ed91e67fedd/1/SFO%20T2%207.jpg">
        </a>
        <a href="/items/3cf238ed-af42-4208-ad04-6ed91e67fedd/1/">
            <img src="/file/3cf238ed-af42-4208-ad04-6ed91e67fedd/1/SFO%20T2,%20SF%202.jpg">
        </a>
        <a href="/items/3cf238ed-af42-4208-ad04-6ed91e67fedd/1/">
            <img src="/file/3cf238ed-af42-4208-ad04-6ed91e67fedd/1/Zendesk%205.jpg">
        </a>
        <a href="/items/1f3ee390-8bcd-4718-97ff-10db79473223/1/">
            <img src="/file/1f3ee390-8bcd-4718-97ff-10db79473223/1/ACCD%20CMTEL%20lab.jpg">
        </a>
        <a href="/items/1f3ee390-8bcd-4718-97ff-10db79473223/1/">
            <img src="/file/1f3ee390-8bcd-4718-97ff-10db79473223/1/ACCD%20CMTEL%20lab%202.jpg">
        </a>
        <a href="/items/1f3ee390-8bcd-4718-97ff-10db79473223/1/">
            <img src="/file/1f3ee390-8bcd-4718-97ff-10db79473223/1/Parsons%20NY%202.jpg">
        </a>
        <a href="/items/1f3ee390-8bcd-4718-97ff-10db79473223/1/">
            <img src="/file/1f3ee390-8bcd-4718-97ff-10db79473223/1/Parsons%20NY.jpg">
        </a>
        <a href="/items/dc6fa382-219c-4ebc-a5cd-50b97c711266/1/">
            <img src="/file/dc6fa382-219c-4ebc-a5cd-50b97c711266/1/European%20Ceramics%20Work%20Centre%20Netherlands%209.jpg">
        </a>
        <a href="/items/dc6fa382-219c-4ebc-a5cd-50b97c711266/1/">
            <img src="/file/dc6fa382-219c-4ebc-a5cd-50b97c711266/1/Kreysler%20_%20Associates%205.jpg">
        </a>
        <a href="/items/dc6fa382-219c-4ebc-a5cd-50b97c711266/1/">
            <img src="/file/dc6fa382-219c-4ebc-a5cd-50b97c711266/1/Kreysler%20_%20Associates%203.jpg">
        </a>
        <a href="/items/dc6fa382-219c-4ebc-a5cd-50b97c711266/1/">
            <img src="/file/dc6fa382-219c-4ebc-a5cd-50b97c711266/1/Kreysler%20_%20Associates%202.jpg">
        </a>
    </div> <#-- end campus planning -->

</div> <#-- end wrapper -->
