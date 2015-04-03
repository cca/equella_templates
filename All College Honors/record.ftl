<#assign itemUuid = xml.get('item/@id')>
<#assign itemversion = xml.get('item/@version')>
<#assign objective = xml.get('local/objective')>
<#assign award = xml.get('local/award')>

<dl>
    <h2 id="title">${xml.get('mods/titleInfo/title')}</h2>

    <dd><b>Creator:</b> ${xml.get('mods/name/namePart')}</dd>
    <dd><b>Competition:</b> ${award}</dd>

    <h3>Applicant Information</h3>
    <dd><b>Email:</b> ${xml.get('mods/name/subNameWrapper/email')}</dd>
    <dd><b>Student ID:</b> ${xml.get('mods/identifier')}</dd>

    <#if objective == 'visual work'>
        <#-- 2D/3D are stored in projectWrapper -->
        <#if xml.exists('local/projectWrapper')>
        <div class="clearfix">
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
        </div>
        </#if> <#-- end 2D/3D section -->

        <#if xml.exists('local/courseWorkWrapper')>
        <div class="clearfix">
        <h3>4D Works</h3>

        <#list xml.getAllSubtrees('item/attachments/attachment') as itemAttachment>
            <#assign full = itemAttachment.get('file')>
            <#assign uuid = itemAttachment.get('uuid')>
            <#list xml.getAllSubtrees('local/courseWorkWrapper') as wrapper>
                <#-- all these fields differ from above projectWrapper ones
                because life is full of pain -->
                <#assign file = wrapper.get('fileA')>
                <#assign title = wrapper.get('projectTitle')>
                <#assign duration = wrapper.get('assignmentLength')>
                <#assign semester = wrapper.get('assignmentDue')>
                <#assign notes = wrapper.get('process_freetext')>
                <#-- videos can be URL attachments, which work differently -->
                <#if file == uuid && type == 'remote'>
                    <div>
                        <#if title != "">
                            <b><a href="${full}" target="_blank">${title}</a></b><br>
                        </#if>
                        <#if duration != "">${duration}<br></#if>
                        <#if semester != "">${semester}<br></#if>
                        <#if notes != "">${notes}<br></#if>
                    </div>
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
        </div>
        </#if> <#-- end 4D works section -->

    </#if> <#-- end visual work section -->

    <#if objective == 'written work'>
        <#if award == 'Graduate Writing - Critical/Nonfiction'>

            <#if (xml.list('local/projectWrapper')?size > 0)>
            <div class="clearfix">
            <h3>Illustrative Images</h3>

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
            </div>
            </#if>

            <div class="clearfix">
                <h3>Critical/Nonfiction Writing</h3>

                <#list xml.getAllSubtrees('item/attachments/attachment') as itemAttachment>
                    <#assign full = itemAttachment.get('file')>
                    <#assign uuid = itemAttachment.get('uuid')>
                    <#-- c/nf isn't in a projectWrapper repeater
                    file is just in this one XML node -->
                    <#assign file = xml.get('mods/part/number')>
                    <#if file == uuid>
                        <div>
                            <a href="/file/${itemUuid}/${itemversion}/${full}"><img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
                        </div>
                    </#if>
                </#list>
            </div>
        </#if> <#-- end critical/nonfiction works section -->

        <#-- creative writing section, cover both poetry & prose in one if stmt -->
        <#if award?substring(0,27) == 'Graduate Writing - Creative'>
            <div class="clearfix">
            <h3>Creative Writing</h3>

            <#list xml.getAllSubtrees('item/attachments/attachment') as itemAttachment>
                <#assign full = itemAttachment.get('file')>
                <#assign uuid = itemAttachment.get('uuid')>
                <#list xml.getAllSubtrees('local/projectWrapper') as wrapper>
                    <#assign file = wrapper.get('fileA')>
                    <#assign title = wrapper.get('title')>
                    <#assign semester = wrapper.get('semester')>
                    <#assign notes = wrapper.get('description')>
                    <#if file == uuid>
                        <div class='image-with-metadata'>
                            <a href="/file/${itemUuid}/${itemversion}/${full}"><img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
                            <p class='metadata'>
                                <#if title != ""><span class="title">${title}</span><br></#if>
                                <#if semester != "">${semester}<br></#if>
                                <#if notes != "">${notes}<br></#if>
                            </p>
                        </div>
                    </#if>
                </#list>
            </#list>
            </div>
        </#if> <#-- end creative writing section -->

    </#if> <#-- end written work section -->

</dl>
