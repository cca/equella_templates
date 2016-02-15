<#assign itemUuid = xml.get('item/@id')>
<#assign itemversion = xml.get('item/@version')>
<#assign itemAttachments = xml.getAllSubtrees('item/attachments/attachment')>

<dl>
    <#assign title = xml.get('mods/titleInfo/title')>
    <h2 id="title">${title}</h2>

    <#list xml.getAllSubtrees('mods/name') as name>
        <#assign namePart = name.get('namePart')>
        <dd><strong>Student:</strong> ${namePart}
        <#list name.getAllSubtrees('subNameWrapper') as subName>
            <#assign major = subName.get('major')>
            <#assign username = subName.get('username')>
            <#assign status = subName.get('constituent')>
            <#assign ccaid = subName.get('ccaAffiliated')>
            <#assign majorUrl = "" />
            <#if major != "">
                 — ${major}
            </#if>
            <#if status != "">
                 — ${status}
            </#if>
            <#if username != "">
                 — ${username}
            </#if>
            <#if ccaid != "">
                 — ${ccaid}
            </#if>
        </#list>
        <br>
    </#list>

    <dd><b>Semester:</b> ${xml.get('local/courseInfo/semester')}</dd>

<#if xml.exists('/local/fileStagingWrappers/fileBstagingWrapper/fileB')>
    <h3>Course Descriptions</h3>
    <#list itemAttachments as itemAttachment>
        <#assign full = itemAttachment.get('file')>
        <#assign uuid = itemAttachment.get('uuid')>
        <#list xml.list('/local/fileStagingWrappers/fileBstagingWrapper/fileB') as file>
            <#if file == uuid>
                <div class="thumbnail">
                    <a href="/file/${itemUuid}/${itemversion}/${full}" rel="group"><img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
                </div>
            </#if>
        </#list>
    </#list>

    <br class="cleafix" />
</#if>

<#if xml.exists('local/projectWrapper/fileA')>
    <h3>Portfolio</h3>

    <#list itemAttachments as itemAttachment>
        <#assign full = itemAttachment.get('file')>
        <#assign uuid = itemAttachment.get('uuid')>
        <#list xml.getAllSubtrees('local/projectWrapper') as wrapper>
            <#assign file = wrapper.get('fileA')>
            <#assign title = wrapper.get('title')>
            <#assign format = wrapper.get('format')>
            <#assign semester = wrapper.get('semester')>
            <#assign description = wrapper.get('description')>
            <#if file == uuid>
                <div class="image-with-metadata">
                    <a href="/file/${itemUuid}/${itemversion}/${full}" rel="group"><img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
                    <p class="metadata">
                        <#if title != ""><span class="title">${title}</span></#if>
                        <#if format != "">${format}<br></#if>
                        <#if semester != "">${semester}<br></#if>
                        <#if description != "">${description}<br></#if>
                    </p>
                </div>
            </#if>
        </#list>
    </#list>
    <hr />
</#if>
