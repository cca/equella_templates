<#assign courseWork = xml.getAllSubtrees('local/courseWorkWrapper')>
<#list courseWork as courseWork>
<#assign courseWorkType = courseWork.get('courseWorkType')>
<#if courseWorkType == "Thesis">
    <dl>
        <#assign itemUuid = xml.get('item/@id')>
        <#assign itemversion = xml.get('item/@version')>
        <#assign attachments = xml.getAllSubtrees('item/attachments/attachment')>
        <#assign powerSearch = 'Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4'>
        <#assign collection = '5a7d71f7-9ffc-41f0-a2ee-2761e78feb11'>

        <#assign title = xml.get('mods/titleInfo/title')>
        <h2 id="title">${title}</h2>

        <#assign division = xml.get('local/division')>
        <#assign department = xml.get('local/department')>
        <#if division != "">
            <dt class="hide">Collection</dt>
            <#assign departmentUrl = "/access/searching.do?in=C${collection}&q=">
            <#assign divisionUrl = "/access/searching.do?in=${powerSearch}&q=">
            <dd class="collection">
                <a href="${departmentUrl}">${department}</a> | <a href="${divisionUrl}">${division}</a>
            </dd>
        </#if>

        <dt>Creator</dt>
        <#list xml.getAllSubtrees('mods/name') as name>
            <#assign namePart = name.get('namePart')>
            <#assign namePartUrl = '/access/searching.do?in=C${collection}&q="${namePart?url}"'>
            <dd><a href="${namePartUrl}">${namePart}</a>
            <#assign majors = name.list('subNameWrapper/major')>
            <#if majors?size != 0> —
                <#list majors as major>
                    <#assign majorUrl = "/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3Cname%3E%3CsubNameWrapper%3E%3Cmajor%3E${major?url}%3C%2Fmajor%3E%3C%2FsubNameWrapper%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=${powerSearch}&q=">
                    <a href="${majorUrl}">${major}</a><#if major_has_next>, </#if>
                </#list>
            </#if>
            </dd>
        </#list>

        <dt>Thesis Information</dt>

        <#assign year = xml.get('mods/origininfo/dateCreatedWrapper/dateCreated')>
        <#if (year != "")>
            <#--  theses from the year, do not use Power Search because it get items from other programs -->
            <#assign yearUrl = "/access/searching.do?in=C${collection}&q=${year?url}+Thesis">
            <dd><b>Year</b>: <a href="${yearUrl}">${year}</a></dd>
        </#if>

        <#assign tags = xml.list('mods/subject/topic')>
        <#--  TODO hyperlink tags  -->
        <#if (tags?size > 0)>
            <dd><b>Tags</b>: <#list tags as tag>${tag}<#if tag_has_next>, </#if></#list>.</dd>
        </#if>

        <#assign abstract = xml.get('mods/abstract')>
        <#if (abstract != "")>
            <dd><b>Description</b><br><pre>${abstract}</pre></dd>
        </#if>
    </dl>
</#if>
</#list>
