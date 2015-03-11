<#assign itemUuid = xml.get('item/@id')>
<#assign itemversion = xml.get('item/@version')>

<dl>
    <h2 id="title">${xml.get('mods/titleInfo/title')}</h2>

    <dd><b>Creator:</b> ${xml.get('mods/name/namePart')}</dd>
    <dd><b>Competition:</b> ${xml.get('local/award')}</dd>

    <h3>Applicant Information</h3>
    <dd><b>Phone:</b> ${xml.get('/local/collectedWork/studentPhone')}</dd>
    <dd><b>Address:</b> ${xml.get('/mods/location/physicalLocation')}</dd>
    <dd><b>Student ID:</b> ${xml.get('/mods/identifier')}</dd>

    <#if xml.exists('local/projectWrapper/fileA')>
        <h3>2D & 3D Works</h3>

        <#list xml.getAllSubtrees('item/attachments/attachment') as itemAttachment>
            <#assign full = itemAttachment.get('file')>
            <#assign uuid = itemAttachment.get('uuid')>
            <#list xml.getAllSubtrees('local/projectWrapper') as wrapper>
                <#assign file = wrapper.get('fileA')>
                <#assign title = wrapper.get('title')>
                <#assign medium = wrapper.get('format')>
                <#assign dimensions = wrapper.get('dimensions')>
                <#assign semester = wrapper.get('semester')>
                <#assign notes = wrapper.get('description')>
                <#if file == uuid>
                    <div class='image-with-metadata'>
                        <a href="/file/${itemUuid}/${itemversion}/${full}"><img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
                        <p class='metadata'>
                            <#if title != ""><span class="title">${title}</span><br></#if>
                            <#if medium != "">${medium}<br></#if>
                            <#if dimensions != "">${dimensions}<br></#if>
                            <#if semester != "">${semester}<br></#if>
                            <#if notes != "">${notes}<br></#if>
                        </p>
                    </div>
                </#if>
            </#list>
        </#list>
    </#if>

    <#if xml.exists('local/projectWrapper/fileB')>
        <h3>4D Works</h3>

        <#list xml.getAllSubtrees('item/attachments/attachment') as itemAttachment>
            <#assign full = itemAttachment.get('file')>
            <#assign uuid = itemAttachment.get('uuid')>
            <#-- will be "remote" for URLs -->
            <#assign type = itemAttachment.get('@type')>
            <#list xml.getAllSubtrees('local/projectWrapper') as wrapper>
                <#assign file = wrapper.get('fileB')>
                <#assign title = wrapper.get('title')>
                <#assign duration = wrapper.get('dimensions')>
                <#assign semester = wrapper.get('semester')>
                <#assign notes = wrapper.get('description')>
                <#if file == uuid && type == 'remote'>
                    <#-- URL attachment -->
                    <p>
                        <#if title != "">
                            <b><a href="${full}" target="_blank">${title}</a><br></b>
                        </#if>
                        <#if duration != "">${duration}<br></#if>
                        <#if semester != "">${semester}<br></#if>
                        <#if notes != "">${notes}<br></#if>
                    </p>
                <#elseif file == uuid>
                    <div class='image-with-metadata'>
                        <a href="/file/${itemUuid}/${itemversion}/${full}"><img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
                        <p class='metadata'>
                            <#if title != ""><span class="title">${title}</span><br></#if>
                            <#if duration != "">${duration}<br></#if>
                            <#if semester != "">${semester}<br></#if>
                            <#if notes != "">${notes}<br></#if>
                        </p>
                    </div>
                </#if>
            </#list>
        </#list>
    </#if>

</dl>
