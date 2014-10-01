<#assign courseWorkType = xml.get('local/courseWorkWrapper/courseWorkType')>
<#if courseWorkType == "Administrative document" || courseWorkType == "Program Portfolio document">
    <dl>
    <#assign accreditation = xml.get('local/accreditation')>
    <#assign courseWorkTypeSpecific = xml.get('local/courseWorkWrapper/courseWorkTypeSpecific')>
    <#assign workType = xml.get('local/courseWorkWrapper/workType')>
    <#assign courseWorkTypeUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseWorkWrapper%3E%3CcourseWorkType%3E${courseWorkType}%3C%2FcourseWorkType%3E%3C%2FcourseWorkWrapper%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&q=&sort=datemodified&dr=AFTER" />
    <#assign dateCreated = xml.get('mods/origininfo/dateCreatedWrapper/dateCreated')>
    <#assign division = xml.get('local/division')>
    <#assign title = xml.get('mods/titleInfo/title')>

    <#if title != ''>
        <h2 id="title">${title}</h2>
    </#if>

    <dt class="hide">Collection</dt>
    <#assign divisionUrl = "/access/searching.do?in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&q=&sort=datemodified&dr=AFTER" />
    <#assign departmentUrl = '/access/searching.do?in=Cdd83789b-f726-47e1-8a5f-626450d226a0&sort=datemodified'>
    <dd class="collection">
        <a href="${divisionUrl}">${division}</a> | <a href="${departmentUrl}">Photography</a>
    </dd>

    <dt>Document Details</dt>

    <dd>Document Type: <a href="${courseWorkTypeUrl}">${courseWorkType}</a>
    <#if courseWorkTypeSpecific != ''>
        <#assign courseWorkTypeSpecificUrl = '/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseWorkWrapper%3E%3CcourseWorkTypeSpecific%3E${courseWorkTypeSpecific}%3C%2FcourseWorkTypeSpecific%3E%3C%2FcourseWorkWrapper%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&q=&sort=datemodified&dr=AFTER'>
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

    <#if accreditation != ''>
        <dd>
            <#assign accreditationUrl = '/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3Caccreditation%3E${accreditation}%3C%2Faccreditation%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&q=&sort=datemodified&dr=AFTER'>
            Flagged for
            <a href="${accreditationUrl}">${accreditation}</a>
        </dd>
    </#if>

    <#assign abstract = xml.get('mods/abstract')>
    <#if abstract != "">
        <dd>Description: ${abstract}</dd>
    </#if>

    </dl>
</#if>
