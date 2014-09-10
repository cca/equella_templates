<#assign itemUuid = xml.get('item/@id')>
<#assign itemversion = xml.get('item/@version')>
<#assign titleInfo = xml.getAllSubtrees('mods/titleInfo')>
<#assign itemAttachments = xml.getAllSubtrees('item/attachments/attachment')>
<#assign name = xml.getAllSubtrees('mods/name')>
<#assign subNameWrapper = xml.getAllSubtrees('mods/name/subNameWrapper')>
<#assign modslevel = xml.getAllSubtrees('mods')>
<#assign courseWork = xml.getAllSubtrees('local/courseWorkWrapper')>
<#assign local = xml.getAllSubtrees('local')>
<#assign origininfo = xml.getAllSubtrees('mods/origininfo')>
<#assign juniorReviewFiles = xml.getAllSubtrees('local/juniorReviewWrapper/fileWrapper')>

<dl>
<#list courseWork as courseWork>
<#assign courseWorkType = courseWork.get('courseWorkType')>
<#if (courseWorkType =="Junior review")>

    <#list titleInfo as titleInfo>
        <#assign title = titleInfo.get('title')>
        <#assign subTitle = titleInfo.get('subTitle')>
        <h2 id="title">${title}
        </h2></dl>
    </#list>

    <dt class="hide">Collection</dt>
    <#list local as local>
        <#assign division = local.get('division')>
        <#-- <dd>${division} -->
        <#assign divisionUrl = "https://vault.cca.edu/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3Cdivision%3E${division}%3C%2Fdivision%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pb0cd301e-6adf-48c5-59aa-9a7a2e7f9834&q=&sort=rank&dr=AFTER" />
        <dd class="collection"><a href="${divisionUrl}">${division}</a></dd>
    </#list>

    <#assign name = xml.getAllSubtrees('mods/name')>
    <#list name as name>
        <#assign namePart = name.get('namePart')>
        <#if (namePart=="")>Incomplete submission - Draft state<#else>
            <dd>${namePart}
        </#if>
        <#list name.getAllSubtrees('subNameWrapper') as subName>
            <#assign major = subName.get('major')>
            <#-- <dd>${major} -->
            <#assign majorUrl = "" />
                 — <a href="${majorUrl}">${major}</a>
        </#list>

        <#list origininfo as origininfo>
            <#assign dateCreated = origininfo.get('dateCreatedWrapper/dateCreated')>
            <#-- <dd>${dateCreated} -->
            <#assign dateCreatedUrl = "" />
             — Junior <a href="${dateCreatedUrl}">${dateCreated}</a>
        </#list>
        </dd>
    </#list>

    <#list modslevel as mods>
        <#assign abstract = mods.get('abstract')>
        <#if (abstract=="")><#else>
            <dd>${abstract}</dd></#if>
    </#list>

    <#list itemAttachments as itemAttachment>
        <#assign thumb = itemAttachment.get('thumbnail')>
        <#assign full = itemAttachment.get('file')>
        <#assign uuid = itemAttachment.get('uuid')>
        <#list juniorReviewFiles as juniorReviewFiles>
            <#assign projectFormat = juniorReviewFiles.get('projectFormat')>
            <#assign file = juniorReviewFiles.get('file')>
            <#if file==uuid>
                <div class='image-studentWork'>
                <a href="https://vault.cca.edu/file/${itemUuid}/${itemversion}/${full}" target="_blank">
                <img src="https://vault.cca.edu/file/${itemUuid}/${itemversion}/${thumb}"/></a>
                <p class='caption'>
                <#if projectFormat==""><#else><i>${projectFormat}</i></#if>
                </p>
                </div>
            </#if>
        </#list>
    </#list>

</#if>
</#list>
