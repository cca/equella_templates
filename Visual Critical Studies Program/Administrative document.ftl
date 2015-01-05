<#function escapeAmp str>
    <#-- returns a URI-encoded "&amp;"
    because we pass XML in the URI, we have to escape this way -->
    <#return str?replace('&', '%26amp%3B')>
</#function>

<#assign courseWorkType = xml.get('local/courseWorkWrapper/courseWorkType')>
<#if courseWorkType == "Administrative document" || courseWorkType == "Program Portfolio document">
    <dl>
    <#assign title = xml.get('mods/titleInfo/title')>
    <#if title != ''>
        <h2 id="title">${title}</h2>
    </#if>

    <dt class="hide">Collection</dt>
    <#assign division = xml.get('local/division')>
    <#assign divisionUrl = "/access/searching.do?in=Pe78fd93a-86cd-40a9-9382-e86897646a2d&q=&sort=datemodified&dr=AFTER" />
    <#assign department = xml.get('local/department')>
    <#assign departmentUrl = '/access/searching.do?in=C49de1037-0279-41b4-8070-0f7ffcbae56d&sort=datemodified'>
    <dd class="collection">
        <#if division != "">
            <a href="${divisionUrl}">${division}</a>
        </#if><#if division != "" && department != "">&nbsp;|&nbsp;</#if>
        <#if department != "">
            <a href="${departmentUrl}">${department}</a>
        </#if>
    </dd>

    <#assign courseWorkTypeSpecific = xml.get('local/courseWorkWrapper/courseWorkTypeSpecific')>
    <#if courseWorkTypeSpecific == 'Alumni successes'>
        <#list xml.getAllSubtrees('mods/name') as name>
            <dt>Alumnus</dt>
            <#assign namePart = name.get('namePart')>
            <#assign namePartUrl = '/access/searching.do?in=Pe78fd93a-86cd-40a9-9382-e86897646a2d&q=${namePart}&sort=datemodified&dr=AFTER'>
            <dd><a href="${namePartUrl}">${namePart}</a>
            <#list name.getAllSubtrees('subNameWrapper') as subName>
                <#assign major = name.get('major')>
                <#assign gradDate = subName.get('gradDate')>
                <#assign majorUrl = "/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3Cname%3E%3CsubNameWrapper%3E%3Cmajor%3E${major}%3C%2Fmajor%3E%3C%2FsubNameWrapper%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=Pe78fd93a-86cd-40a9-9382-e86897646a2d&q=&sort=datemodified&dr=AFTER" />
                <#assign gradDateUrl = "/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3Cname%3E%3CsubNameWrapper%3E%3CgradDate%3E${gradDate}%3C%2FgradDate%3E%3C%2FsubNameWrapper%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=Pe78fd93a-86cd-40a9-9382-e86897646a2d&q=&sort=datemodified&dr=AFTER" />
                <#if major != ""> — <a href="${majorUrl}">${major}</a></#if>
                <#if gradDate != ""> — Graduated: <a href="${gradDateUrl}">${gradDate}</a></#if>
            </#list>
            </dd>
        </#list>
    </#if>

    <dt>Document Details</dt>

    <#assign workType = xml.get('local/courseWorkWrapper/workType')>
    <#assign courseWorkTypeUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3Cdepartment%3EVisual+Critical+Studies%3C%2Fdepartment%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3E${escapeAmp(courseWorkType)}%3C%2FcourseWorkType%3E%3C%2FcourseWorkWrapper%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pe78fd93a-86cd-40a9-9382-e86897646a2d&q=&sort=datemodified&dr=AFTER" />
    <dd>Document Type: <a href="${courseWorkTypeUrl}">${courseWorkType}</a>
    <#if courseWorkTypeSpecific != ''>
        <#assign courseWorkTypeSpecificUrl = '/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3Cdepartment%3EVisual+Critical+Studies%3C%2Fdepartment%3E%3CcourseWorkWrapper%3E%3CcourseWorkTypeSpecific%3E${escapeAmp(courseWorkTypeSpecific)}%3C%2FcourseWorkTypeSpecific%3E%3C%2FcourseWorkWrapper%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pe78fd93a-86cd-40a9-9382-e86897646a2d&q=&sort=datemodified&dr=AFTER'>
        | <a href="${courseWorkTypeSpecificUrl}">${courseWorkTypeSpecific}</a>
    </#if>
    <#if workType != '' && workType != 'undefined'>
        <#assign workTypeUrl = '/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3Cdepartment%3EVisual+Critical+Studies%3C%2Fdepartment%3E%3CcourseWorkWrapper%3E%3CworkType%3E${escapeAmp(workType)}%3C%2FworkType%3E%3C%2FcourseWorkWrapper%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pe78fd93a-86cd-40a9-9382-e86897646a2d&q=&sort=datemodified&dr=AFTER'>
        | <a href="${workTypeUrl}">${workType}</a>
    </#if>
    </dd>
    <#assign dateCreated = xml.get('mods/origininfo/dateCreatedWrapper/dateCreated')>
    <#if dateCreated != "">
        <dd>Date created: ${dateCreated}</dd>
    </#if>

    <#list xml.getAllSubtrees('item/attachments/attachment') as attachment>
        <#if attachment.get('@type') == 'remote'>
            <#assign url = attachment.get('file')>
            <dd>
                Link: <a href="${url}">${url}</a>
            </dd>
        </#if>
    </#list>

    <#assign accreditation = xml.get('local/accreditation')>
    <#if accreditation != ''>
        <dd>
            <#-- @todo why doesn't this work?!? -->
            <#assign accreditationUrl = '/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3Caccreditation%3E${accreditation}%3C%2Faccreditation%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pe78fd93a-86cd-40a9-9382-e86897646a2d&q=&sort=datemodified&dr=AFTER'>
            Flagged for ${accreditation}
        </dd>
    </#if>

    <#assign abstract = xml.get('mods/abstract')>
    <#if abstract != "">
        <dd>Description: ${abstract}</dd>
    </#if>

    <#-- print Bio/CV up above rest of attachments to highlight it -->
    <#list xml.getAllSubtrees('item/attachments/attachment') as attachment>
        <#assign file = attachment.get('file')>
        <#if file?ends_with('.pdf') && workType == 'Faculty bios'>
            <#assign uuid = attachment.get('uuid')>
            <#assign itemUuid = xml.get('item/@id')>
            <#assign itemVersion = xml.get('item/@version')>
            <dd>
                <a class="clearfix" href="/file/${itemUuid}/${itemVersion}/${file}"><img src="/thumbs/${itemUuid}/${itemVersion}/${uuid}" alt="bio or CV"></a>
                <p>Bio/CV document (PDF)</p>
            </dd>
        </#if>
    </#list>

    </dl>
</#if>
