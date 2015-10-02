<#assign itemUuid = xml.get('item/@id')>
<#assign itemversion = xml.get('item/@version')>

<#if xml.get('local/courseWorkWrapper/courseWorkType') == 'Junior review'>
<dl>

    <#assign title = xml.get('mods/titleInfo/title')>
    <h2 id="title">${title}</h2></dl>

    <dt class="hide">Collection</dt>
    <#assign division = xml.get('local/division')>
    <#assign divisionUrl = "/access/searching.do?in=C1ca1ba6f-e327-4557-9b7e-25e1bba1b359&q=&dr=AFTER">
    <dd class="collection"><a href="${divisionUrl}">${division}</a></dd>

    <#list xml.getAllSubtrees('mods/name') as name>
        <#assign namePart = name.get('namePart')>
        <dd>
        <#if namePart == "">Incomplete submission - Draft state<#else>
            ${namePart}
        </#if>
        <#list name.getAllSubtrees('subNameWrapper') as subName>
            <#assign major = subName.get('major')>
            <#assign majorUrl = "" />
                 — <a href="${majorUrl}">${major}</a>
        </#list>
        <#assign dateCreated = xml.get('mods/origininfo/dateCreatedWrapper/dateCreated')>
        <#assign dateCreatedUrl = "" />
         — Junior <a href="${dateCreatedUrl}">${dateCreated}</a>
        </dd>
    </#list>

    <#assign selfEvaluation = xml.get('local/juniorReviewWrapper/selfEvaluation')>
    <#if selfEvaluation != ""><dd><b>Self Evaluation:</b> ${selfEvaluation}</dd></#if>

    <#-- presentation PDF -->
    <#list xml.getAllSubtrees('item/attachments/attachment') as itemAttachment>
        <#assign full = itemAttachment.get('file')>
        <#assign uuid = itemAttachment.get('uuid')>
        <#assign file = xml.get('local/juniorReviewWrapper/file')>
        <#if file == uuid>
        <div class="image-with-metadata">
            <a href="/file/${itemUuid}/${itemversion}/${full}" target="_blank">
            <img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
            <p class="metadata">
                <i>Presentation</i>
            </p>
        </div>
        </#if>
    </#list>

    <#list xml.getAllSubtrees('item/attachments/attachment') as itemAttachment>
        <#assign full = itemAttachment.get('file')>
        <#assign uuid = itemAttachment.get('uuid')>
        <#list xml.getAllSubtrees('local/juniorReviewWrapper/fileWrapper') as juniorReviewFile>
            <#assign projectFormat = juniorReviewFile.get('projectFormat')>
            <#assign file = juniorReviewFile.get('file')>
            <#if file == uuid>
                <div class="image-with-metadata">
                    <a href="/file/${itemUuid}/${itemversion}/${full}" target="_blank">
                    <img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
                    <p class="metadata">
                        <#if projectFormat != "">
                            <i>${projectFormat}</i>
                            <#-- BArch stores evaluation form here -->
                        <#elseif xml.get('local/department') == 'Architecture (BArch)'>
                            <i>Evaluation form</i>
                        </#if>
                    </p>
                </div>
            </#if>
        </#list>
    </#list>
</#if>
