<#function escapeAmp str>
    <#-- returns a URI-encoded "&amp;"
    because we are passing XML in the URI, we have to escape this way -->
    <#return str?replace('&', '%26amp%3B')>
</#function>

<#assign itemUuid = xml.get('item/@id')>
<#assign itemversion = xml.get('item/@version')>
<#-- this is the Design Division power search ID -->
<#assign powerSearch = 'P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3'>
<#assign itemAttachments = xml.getAllSubtrees('item/attachments/attachment')>
<#assign courseWork = xml.getAllSubtrees('local/courseWorkWrapper')>
<#assign local = xml.getAllSubtrees('local')>

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
            <#assign divisionUrl = "/access/searching.do?doc=%3Cxml%2F%3E&in=${powerSearch}&q=&sort=datemodified&dr=AFTER">
            <#assign departmentUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=&sort=datemodified&dr=AFTER">
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

    <dt>Workshop Event Information</dt>
    <#list local as local>
        <#assign objective = local.get('objective')>
        <#assign objectiveUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=%22${objective}%22&dr=AFTER">
        <dd><a href="${objectiveUrl}">${objective}</a>
    </#list>

    <#list xml.getAllSubtrees('mods/origininfo') as origininfo>
        <#assign dateCreated = origininfo.get('dateCreatedWrapper/dateCreated')>
        <#if dateCreated != "">${dateCreated}</#if>
        </dd>
    </#list>

    <#assign tags = xml.list('local/tags')>
    <#if tags?size != 0>
        <dd><b>Tags</b>:<br>
         <#list tags as tag>
            <#assign tagUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3Ctags%3E${tag}%3C%2Ftags%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER">
            <a href="${tagUrl}">${tag}</a><#if tag_has_next>, </#if>
        </#list></dd>
    </#if>

    <#assign abstract = xml.get('mods/abstract')>
    <#if abstract != "">
        <dd><b>Description</b>:<br><pre>${abstract}</pre></dd>
    </#if>

    <#assign names = xml.getAll('mods/subject/name')>
    <#if names?size != 0>
        <dd><b>People in photos</b>:
            <#list names as name>
                ${name}<#if name_has_next>, </#if>
            </#list>
        </dd>
    </#if>

</dl>
</#if>
</#list>
