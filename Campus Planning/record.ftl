<#assign itemUuid = xml.get('item/@id')>
<#assign itemversion = xml.get('item/@version')>
<#assign itemAttachments = xml.getAllSubtrees('item/attachments/attachment')>
<#assign parts = xml.getAllSubtrees('mods/part')>
<#assign broadCategory = xml.get('mods/genreWrapper/genre')>

<dl>
    <#if broadCategory != "">
        <h2 id="title">${broadCategory}</h2>
    </#if>

<dt>Images</dt>
<div class="js-masonry" data-masonry-options='{ "columnWidth": 130, "itemSelector": ".image-photoSeniorPacket" }'>
<#list itemAttachments as itemAttachment>
    <#assign thumb = itemAttachment.get('thumbnail')>
    <#assign full = itemAttachment.get('file')>
    <#assign uuid = itemAttachment.get('uuid')>
    <#assign size = itemAttachment.get('size')>

    <div class='image-photoSeniorPacket'>
        <#assign imgUrl = "/file/${itemUuid}/${itemversion}/${full}">
        <#assign thumbUrl = "/thumbs/${itemUuid}/${itemversion}/${uuid}">
        <#-- attachment > 10mb? set a class on it
        so we don't do fancybox down at the bottom -->
        <#if (size?has_content && size?number > 10000000)>
            <#-- Masonry layout needs width/height attrs to know how to
            rearrange them
            onclick attr is how EQUELLA does its pop-ups -->
            <a href="${imgUrl}" class="largeFile"
                onclick="popup('/items/${itemUuid}/${itemversion}/${full}?.vi=toimg',null,'80%','80%');return false;">
                <img src="${thumbUrl}" width="88" height="66"/></a>
        <#else>
            <a href="${imgUrl}"><img src="${thumbUrl}" width="88" height="66"/></a>
        </#if>

        <#list parts as part>
            <#assign number = part.get('number')>
            <#if number == uuid>
                <#assign title = part.get('title')>
                <#assign location = part.get('extent')>
                <#assign photoCredit = part.get('text')>
                <#assign description = part.get('detail')>
                <#assign tags = part.get('wrapperOther/tags')>
                <p class='commImagelist'>
                    <#if title != "">
                        <strong>${title}</strong><br><br>
                    </#if>
                    <#if location != "">
                        ${location}<br>
                    </#if>
                    <#if description != "">
                        ${description}<br>
                    </#if>
                </p>
                <#list part.getAllSubtrees('wrapperOther') as tagWrap>
                    <#assign tags = tagWrap.get('tags')>
                    <#if tags != "">
                        <p class='commImagelist'>${tags}</p>
                    </#if>
                </#list>

                <#if photoCredit != "">
                    <p class='commImagelist'>Photographer: ${photoCredit}</p>
                </#if>
            </#if>
        </#list>
    </div>
</#list>
</div>

</dl>

<#-- modal boxes for images
EQUELLA already comes with jQuery.fancybox script
see http://fancybox.net -->
<script>
jQuery('.image-photoSeniorPacket a img').parent().not('.largeFile').fancybox();
</script>

<style>
div.image-photoSeniorPacket {
    margin-bottom: 10px;
    min-height: 80px;
}
</style>
<script src="//cdn.jsdelivr.net/masonry/3.1.5/masonry.min.js"></script>
