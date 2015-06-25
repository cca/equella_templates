<#assign itemUuid = xml.get('item/@id')>
<#assign itemversion = xml.get('item/@version')>
<#assign attachments = xml.getAllSubtrees('item/attachments/attachment')>
<#assign pages = xml.getAllSubtrees('mods/part/numberB')>
<#assign configID = xml.get('mods/identifier')>

<dl class="clearfix">
<#assign title = xml.get('mods/titleInfo/title')>
<h2 id="title">${title}</h2>

<#if pages?size != 0>
    <#-- HTML5 flipbook, see turnjs.com (jQuery dependency) -->
    <script src="//cdn.jsdelivr.net/turn.js/3/turn.min.js"></script>
    <style>
    #flipbook {
        width: 400px;
        height: 300px;
    }
    #flipbook .turn-page {
        background-color: #ccc;
    }
    #flipbook .turn-page img {
        max-width: 100%;
    }
    </style>
    <div id="flipbook">
    <#list pages as page><#list attachments as attachment>
        <#if attachment.get('uuid') == page.get('/')>
            <div>
                <img src="/file/${itemUuid}/${itemversion}/${attachment.get('file')}" />
            </div>
        </#if>
    </#list></#list>
    </div>
    <script>
	$($("#flipbook").turn({
		width: 400,
		height: 300
	}));
    </script>
</#if>

<#list xml.getAllSubtrees('mods/relateditem') as relateditem>
    <#assign title = relateditem.get('title')>
    <#assign location = relateditem.get('location')>
    <#assign issuuLink = relateditem.get('note')>
    <#assign @type = relateditem.get('@type')>
    <#if issuuLink == "">
        <div id="images">
        <#list attachments as attachment>
            <#assign full = attachment.get('file')>
            <#assign uuid = attachment.get('uuid')>
            <#-- @todo multiple of the same ID problem here -->
            <div id="image-single">
                <a href="/file/${itemUuid}/${itemversion}/${full}">
                <img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
                <#list xml.getAllSubtrees('mods/part') as part>
                    <#assign parttitle = part.get('title')>
                    <#assign partextent = part.get('extent')>
                    <#assign partnumber = part.get('number')>
                    <#if partnumber == uuid>
                        <#if parttitle != "" || partextent != "" || partnumber != "">
                            <p class='caption'>
                                <#if parttitle != ""><em>${parttitle} </em><br></#if>
                                <#if partextent != ""> ${partextent}</#if>
                            </p>
                        </#if>
                    </#if>
                </#list>
            </div>
        </#list>
        </div>
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
