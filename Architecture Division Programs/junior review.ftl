
<#if xml.get('local/courseWorkWrapper/submissionType') =="Junior review">
<dl>

    <#assign title = xml.get('mods/titleInfo/title')>
    <h2 id="title">${title}</h2></dl>

    <dt class="hide">Collection</dt>
    <#assign division = xml.get('local/division')>
    <#assign divisionUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3Cdivision%3E${division}%3C%2Fdivision%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pb0cd301e-6adf-48c5-59aa-9a7a2e7f9834&q=&sort=rank&dr=AFTER" />
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

    <#assign itemUuid = xml.get('item/@id')>
    <#assign itemversion = xml.get('item/@version')>
    <#list xml.getAllSubtrees('item/attachments/attachment') as itemAttachment>
        <#assign full = itemAttachment.get('file')>
        <#assign uuid = itemAttachment.get('uuid')>
        <#list xml.getAllSubtrees('local/juniorReviewWrapper/fileWrapper') as juniorReviewFile>
            <#assign projectFormat = juniorReviewFile.get('projectFormat')>
            <#assign file = juniorReviewFile.get('file')>
            <#if file == uuid>
                <div class='image-studentWork'>
                    <a href="/file/${itemUuid}/${itemversion}/${full}" target="_blank">
                    <img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
                    <p class='caption'>
                        <#if projectFormat != ""><i>${projectFormat}</i></#if>
                    </p>
                </div>
            </#if>
        </#list>
    </#list>

</#if>
