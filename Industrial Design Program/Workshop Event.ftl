<#assign itemUuid = xml.get('item/@id')>
<#assign itemversion = xml.get('item/@version')>
<#assign itemAttachments = xml.getAllSubtrees('item/attachments/attachment')>
<#assign subject = xml.getAllSubtrees('mods/subject')>
<#assign courseWork = xml.getAllSubtrees('local/courseWorkWrapper')>
<#assign local = xml.getAllSubtrees('local')>
<#assign origininfo = xml.getAllSubtrees('mods/origininfo')>


<#list courseWork as courseWork>
<#assign courseWorkType = courseWork.get('courseWorkType')>
<#if (courseWorkType == "Workshop / Events")>
<dl>
    <#assign title = xml.get('mods/titleInfo/title')>
    <#assign subTitle = xml.get('mods/titleInfo/subTitle')>
    <h2 id="title">${title}</h2>

    <dt class="hide">Collection</dt>
        <#list local as local>
            <#assign division = local.get('division')>
            <#assign department = local.get('department')>
            <#assign divisionUrl = "/access/searching.do?doc=%3Cxml%2F%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />
            <#assign departmentUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />
            <dd class="collection"><a href="${departmentUrl}">${department}</a> | <a href="${divisionUrl}">${division}</a></dd>
        </#list>

    <div id="images">
    <#list itemAttachments as itemAttachment>
        <#assign uuid = itemAttachment.get('uuid')>
        <#assign full = itemAttachment.get('file')>
        <#if full?contains("http://") || full?ends_with(".zip")><#else>
            <a href="/file/${itemUuid}/${itemversion}/${full}">
            <img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
        </#if>
    </#list>
    </div>

    <dt>Workshop / Event Information</dt>
    <#list local as local>
        <#assign objective = local.get('objective')>
        <#-- @todo fix this URL -->
        <#assign objectiveUrl = "" />
        <dd><a href="${objectiveUrl}">${objective}</a>
    </#list>

    <#list origininfo as origininfo>
        <#assign dateCreated = origininfo.get('dateCreatedWrapper/dateCreated')>
        <#assign semesterCreated = origininfo.get('semesterCreated')>
        <#-- @todo fix this URL -->
        <#assign semesterCreatedUrl = "" />
         — <#if semesterCreated != "">
            Date:
            <a href="${semesterCreatedUrl}">${semesterCreated}</a> |
        </#if>
        <#if dateCreated != "">${dateCreated}</#if>
        </dd>
    </#list>

    <#list local as local>
            <#-- list() returns a list of text inside nodes -->
            <#assign tags = xml.list('local/tags')>
            <#if tags?size != 0>
                 — <#list tags as tag>
                    <#-- assign URL inside of loop -->
                    <#assign tagUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseWorkWrapper%2F%3E%3Ctags%3E${tag}%3C%2Ftags%3E%3C%2Flocal%3E%3Cmods%3E%3CphysicalDescription%2F%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />
                    <a href="${tagUrl}">${tag}</a><#if tag_has_next>, </#if>
                </#list>
            </#if>
        </#list>

    <#assign abstract = xml.get('mods/abstract')>
    <#if (abstract != "")><dd>Description: ${abstract}</dd></#if>

    <#assign name = xml.getAllSubtrees('mods/subject/name')>
    <#list subject as subject>
        <#assign namex = subject.get('name')>
        <#assign nameUrl = "" />
        <#if namex != "">
            <dd>People in photos:
                <#list name as name>
                    <a href="${nameUrl}">${name}</a><#if name_has_next>, </#if>
                </#list>
            </dd>
        </#if>
    </#list>

</dl>
</#if>
</#list>
