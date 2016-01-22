<#assign itemUuid = xml.get('item/@id')>
<#assign itemversion = xml.get('item/@version')>
<#assign itemAttachments = xml.getAllSubtrees('item/attachments/attachment')>
<#assign courseWork = xml.getAllSubtrees('local/courseWorkWrapper')>

<#list courseWork as courseWork>
<#assign courseWorkType = courseWork.get('courseWorkType')>
<#if courseWorkType == "Junior review">
<dl>

    <#list xml.getAllSubtrees('mods/titleInfo') as titleInfo>
        <#assign title = titleInfo.get('title')>
        <#assign subTitle = titleInfo.get('subTitle')>
        <h2 id="title">${title}
        </h2></dl>
    </#list>

    <dt class="hide">Collection</dt>
    <#list xml.getAllSubtrees('local') as local>
        <#assign division = local.get('division')>
        <#assign divisionUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3Cdivision%3E${division}%3C%2Fdivision%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pb0cd301e-6adf-48c5-59aa-9a7a2e7f9834&q=&sort=rank&dr=AFTER">
        <#assign department = xml.get('local/department')>
        <#assign departmentUrl = "/access/searching.do?in=C875c9189-6e48-40f2-a00e-c64bc714440c&q=&type=standard&dr=AFTER">
        <dd class="collection">
            <a href="${divisionUrl}">${division}</a>
        </dd>
    </#list>

    <#assign name = xml.getAllSubtrees('mods/name')>
    <#list name as name>
        <#assign namePart = name.get('namePart')>
        <#if (namePart=="")>Incomplete submission - Draft state<#else>
            <dd>${namePart}
        </#if>
        <#list name.getAllSubtrees('subNameWrapper') as subName>
            <#assign major = subName.get('major')>
            <#assign majorUrl = "/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3Cname%3E%3CsubNameWrapper%3E%3Cmajor%3E${major}%3C%2Fmajor%3E%3C%2FsubNameWrapper%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />
                 — <a href="${majorUrl}">${major}</a>
        </#list>

        <#list xml.getAllSubtrees('mods/origininfo') as origininfo>
            <#assign dateCreated = origininfo.get('dateCreatedWrapper/dateCreated')>
            <#assign dateCreatedUrl = "" />
             — Junior <a href="${dateCreatedUrl}">${dateCreated}</a>
        </#list>
        </dd>
    </#list>

    <#list xml.getAllSubtrees('mods') as mods>
        <#assign abstract = mods.get('abstract')>
        <#if (abstract != "")>
            <dd>${abstract}</dd></#if>
    </#list>

    <#list itemAttachments as itemAttachment>
        <#assign thumb = itemAttachment.get('thumbnail')>
        <#assign full = itemAttachment.get('file')>
        <#assign uuid = itemAttachment.get('uuid')>
        <#list xml.getAllSubtrees('local/juniorReviewWrapper/fileWrapper') as juniorReviewFiles>
            <#assign projectFormat = juniorReviewFiles.get('projectFormat')>
            <#assign file = juniorReviewFiles.get('file')>
            <#if file == uuid>
                <div class="image-studentWork">
                    <a href="/file/${itemUuid}/${itemversion}/${full}" rel="group" target="_blank">
                    <img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
                    <p class="caption">
                        <#if projectFormat != ""><i>${projectFormat}</i></#if>
                    </p>
                </div>
            </#if>
        </#list>
    </#list>

</#if>
</#list>
