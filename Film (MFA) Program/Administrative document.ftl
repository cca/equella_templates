<#--
change these variables depending upon collection
-->
<#-- the UUID for the divisional Power Search, this one is Fine Arts -->
<#assign powerSearch = 'Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4'>
<#-- UUID for specific collection, begins with C -->
<#assign collectionID = 'Cbd31bc79-0ee3-4ed8-a0f0-2b47f0555b10'>

<#assign courseWorkType = xml.get('local/courseWorkWrapper/courseWorkType')>
<#if courseWorkType == "Administrative document" || courseWorkType == "Program Portfolio document">
    <dl>
    <#assign courseWorkTypeSpecific = xml.get('local/courseWorkWrapper/courseWorkTypeSpecific')>
    <#assign workType = xml.get('local/courseWorkWrapper/workType')>
    <#assign courseWorkTypeUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3E${courseWorkType}%3C%2FcourseWorkType%3E%3C%2FcourseWorkWrapper%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER">
    <#assign dateCreated = xml.get('mods/origininfo/dateCreatedWrapper/dateCreated')>

    <#assign title = xml.get('mods/titleInfo/title')>
    <#if title != ''><h2 id="title">${title}</h2></#if>

    <dt class="hide">Collection</dt>
    <#assign division = xml.get('local/division')>
    <#assign divisionUrl = "/access/searching.do?in=${powerSearch}&q=&dr=AFTER">
    <#assign departmentUrl = '/access/searching.do?in=${collectionID}&sort=datemodified'>
    <dd class="collection">
        <a href="${divisionUrl}">${division}</a> | <a href="${departmentUrl}">${xml.get('local/department')}</a>
    </dd>

    <#if courseWorkTypeSpecific == 'Alumni successes'>
        <#list xml.getAllSubtrees('mods/name') as name>
            <dt>Alumnus</dt>
            <#assign namePart = name.get('namePart')>
            <#assign namePartUrl = '/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3Cname%3E%3CnamePart%3E${namePart}%3C%2FnamePart%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER'>
            <dd><a href="${namePartUrl}">${namePart}</a>
            <#list name.getAllSubtrees('subNameWrapper') as subName>
                <#assign major = name.get('major')>
                <#assign gradDate = subName.get('gradDate')>
                <#assign majorUrl = "/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3Cname%3E%3CsubNameWrapper%3E%3Cmajor%3E${major}%3C%2Fmajor%3E%3C%2FsubNameWrapper%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER">
                <#assign gradDateUrl = "/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3Cname%3E%3CsubNameWrapper%3E%3CgradDate%3E${gradDate}%3C%2FgradDate%3E%3C%2FsubNameWrapper%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER">
                <#if major != ""> — <a href="${majorUrl}">${major}</a></#if>
                <#if gradDate != ""> — Graduated: <a href="${gradDateUrl}">${gradDate}</a></#if>
            </#list>
            </dd>
        </#list>
    </#if>

    <dt>Document Details</dt>

    <dd>Document Type: <a href="${courseWorkTypeUrl}">${courseWorkType}</a>
    <#if courseWorkTypeSpecific != ''>
        <#assign courseWorkTypeSpecificUrl = '/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseWorkWrapper%3E%3CcourseWorkTypeSpecific%3E${courseWorkTypeSpecific}%3C%2FcourseWorkTypeSpecific%3E%3C%2FcourseWorkWrapper%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER'>
        | <a href="${courseWorkTypeSpecificUrl}">${courseWorkTypeSpecific}</a>
    </#if>
    <#if workType != '' && workType != 'undefined'>
        <#assign workTypeUrl = ''>
        | <a href="${workTypeUrl}">${workType}</a>
    </#if>
    </dd>
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
        <dd>Flagged for ${accreditation}</dd>
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
