<#assign itemUuid = xml.get('item/@id')>
<#assign itemversion = xml.get('item/@version')>
<#assign configID = xml.getAllSubtrees('mods/identifier')>

<dl class="clearfix">
<#assign title = xml.get('mods/titleInfo/title')>
<h2 id="title">${title}</h2>

<#list xml.getAllSubtrees('mods/relateditem') as relateditem>
    <#assign title = relateditem.get('title')>
    <#assign location = relateditem.get('location')>
    <#assign issuuLink = relateditem.get('note')>
    <#assign @type = relateditem.get('@type')>
    <#if issuuLink == "">
        <div id="images">
        <#list xml.getAllSubtrees('item/attachments/attachment') as itemAttachment>
            <#assign full = itemAttachment.get('file')>
            <#assign uuid = itemAttachment.get('uuid')>
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
