<#assign itemUuid = xml.get('item/@id')>
<#assign itemversion = xml.get('item/@version')>
<#assign title = xml.getAllSubtrees('mods/titleInfo')>
<#assign collection = xml.getAllSubtrees('mods/relatedItem')>
<#assign itemAttachments = xml.getAllSubtrees('item/attachments/attachment')>
<#assign modslevel = xml.getAllSubtrees('mods')>
<#assign originInfo = xml.getAllSubtrees('mods/originInfo')>
<#assign relateditem = xml.getAllSubtrees('mods/relateditem')>
<#assign configID = xml.getAllSubtrees('mods/identifier')>
<#assign part = xml.getAllSubtrees('mods/part')>

<dl>
<#list title as mods>
    <#assign title = mods.get('title')>
    <h2 id="title">${title}
    </h2>
</#list>

<#list relateditem as relateditem>
    <#assign title = relateditem.get('title')>
    <#assign location = relateditem.get('location')>
    <#assign issuuLink = relateditem.get('note')>
    <#assign @type = relateditem.get('@type')>
    <#list modslevel as modslevel>
        <#assign configID = modslevel.get('identifier')>
        <#if issuuLink=="">
            <div id="images">
            <#list itemAttachments as itemAttachment>
                <#assign thumb = itemAttachment.get('thumbnail')>
                <#assign full = itemAttachment.get('file')>
                <#assign uuid = itemAttachment.get('uuid')>
                <div id='image-single'>
                    <a href="/file/${itemUuid}/${itemversion}/${full}">
                    <img src="/items/${itemUuid}/${itemversion}/${thumb}"/></a>
                    <#list part as partAttachment>
                        <#assign parttitle = partAttachment.get('title')>
                        <#assign partextent = partAttachment.get('extent')>
                        <#assign partnumber = partAttachment.get('number')>
                        <#if partnumber==uuid>
                            <#if parttitle=="" && partextent=="" && partnumber=="">
                            <#else>
                                <p class='caption'>
                                    <#if parttitle==""><#else><em>${parttitle} </em></#if>
                                    <#if parttitle!=""><br /> <#else></#if>
                                    <#if partextent==""><#else> ${partextent}</#if>
                                </p>
                            </#if>
                        <#else></#if>
                    </#list>
                </div>
            </#list>
            </div>
        <#elseif issuuLink!="">
            <div data-configid="${configID}" style="width: 525px; height: 525px;" class="issuuembed"></div>
            <script type="text/javascript" src="//e.issuu.com/embed.js" async="true"></script>
        </#if>
    </#list>

    <#if (title != "" && location != "")>
        <#if relateditem_index == 0><dt>Related item</dt><#else>
        </#if>
        <dd>
            <#if @type == "isReferencedBy">Referenced by:<#else>
            </#if>
            <em><#if location != ""><a href="${location}"></#if>${title}</a></em>
        </dd>
    </#if>
</#list>
</dl>
