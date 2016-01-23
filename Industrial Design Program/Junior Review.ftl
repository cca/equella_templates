<#assign itemUuid = xml.get('item/@id')>
<#assign itemversion = xml.get('item/@version')>
<#assign itemAttachments = xml.getAllSubtrees('item/attachments/attachment')>
<#assign courseWork = xml.getAllSubtrees('local/courseWorkWrapper')>
<#assign local = xml.getAllSubtrees('local')>
<#assign origininfo = xml.getAllSubtrees('mods/origininfo')>
<#assign juniorReviewFiles = xml.getAllSubtrees('local/juniorReviewWrapper/fileWrapper')>

<#list courseWork as courseWork>
<#assign courseWorkType = courseWork.get('courseWorkType')>
<#if courseWorkType == "Junior Review portfolio">
<dl>
    <#assign title = xml.get('mods/titleInfo/title')>
    <h2 id="title">${title}</h2>

    <dt class="hide">Collection</dt>
        <#list local as local>
            <#assign division = local.get('division')>
            <#assign department = local.get('department')>
            <#assign divisionUrl = "/access/searching.do?doc=%3Cxml%2F%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />
            <#assign departmentUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />
            <dd class="collection"><a href="${departmentUrl}">${department}</a> | <a href="${divisionUrl}">${division}</a></dd>
        </#list>

    <#assign name = xml.getAllSubtrees('mods/name')>
    <#list name as name>
        <#assign namePart = name.get('namePart')>
        <#if namePart == "">Incomplete submission - Draft state<#else>
            <dd>${namePart}
        </#if>
        <#list name.getAllSubtrees('subNameWrapper') as subName>
            <#assign major = subName.get('major')>
            <#assign majorUrl = "/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3Cname%3E%3CsubNameWrapper%3E%3Cmajor%3E${major}%3C%2Fmajor%3E%3C%2FsubNameWrapper%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />
                 — <a href="${majorUrl}">${major}</a>
        </#list>

        <#list origininfo as origininfo>
            <#assign dateCreated = origininfo.get('dateCreatedWrapper/dateCreated')>
            <#assign dateCreatedUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3Cdepartment%3EIndustrial+Design%3C%2Fdepartment%3E%3Ctags%2F%3E%3C%2Flocal%3E%3Cmods%3E%3Corigininfo%3E%3CdateCreatedWrapper%3E%3CdateCreated%3E${dateCreated}%3C%2FdateCreated%3E%3C%2FdateCreatedWrapper%3E%3C%2Forigininfo%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />
             — Junior <a href="${dateCreatedUrl}">${dateCreated}</a>
        </#list>
        </dd>
    </#list>

    <#assign abstract = xml.get('mods/abstract')>
    <#if abstract != "">
        <dd>${abstract}</dd>
    </#if>

    <#list itemAttachments as itemAttachment>
        <#assign full = itemAttachment.get('file')>
        <#assign uuid = itemAttachment.get('uuid')>
        <#list juniorReviewFiles as juniorReviewFiles>
            <#assign projectFormat = juniorReviewFiles.get('projectFormat')>
            <#assign file = juniorReviewFiles.get('file')>
            <#if file == uuid>
                <div class="image-studentWork">
                    <a href="/file/${itemUuid}/${itemversion}/${full}" rel="group">
                    <img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
                    <p class="caption">
                        <#if projectFormat != ""><i>${projectFormat}</i></#if>
                    </p>
                </div>
            </#if>
        </#list>
    </#list>

    <div style="clear:both;"></div>
    <#list itemAttachments as itemAttachment>
        <#assign type = itemAttachment.get('@type')>
        <#assign full = itemAttachment.get('file')>
        <dd><#if type == "remote">
            Related link: <a href="${full}">${full}</a>
            </#if>
        </dd>
    </#list>
</dl>
</#if>
</#list>
