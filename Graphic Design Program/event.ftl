<#assign itemUuid = xml.get('item/@id')>
<#assign itemversion = xml.get('item/@version')>
<#assign titleInfo = xml.getAllSubtrees('mods/titleInfo')>
<#assign itemAttachments = xml.getAllSubtrees('item/attachments/attachment')>
<#assign modslevel = xml.getAllSubtrees('mods')>
<#assign subject = xml.getAllSubtrees('mods/subject')>
<#assign courseWork = xml.getAllSubtrees('local/courseWorkWrapper')>
<#assign local = xml.getAllSubtrees('local')>
<#assign origininfo = xml.getAllSubtrees('mods/origininfo')>

<#list courseWork as courseWork>
    <#assign groupProject = courseWork.get('groupProject')>
    <#assign groupMembers = courseWork.get('groupMembers')>
    <#assign courseWorkType = courseWork.get('courseWorkType')>
    <#assign groupProjectUrl = "" />
    <#assign courseWorkTypeUrl = "" />
    <#if courseWorkType=="Workshop / Events">

    <dl>
    <#list titleInfo as titleInfo>
        <#assign title = titleInfo.get('title')>
        <h2 id="title">${title}
        </h2>
    </#list>

    <dt class="hide">Collection</dt>
        <#list local as local>
            <#assign division = local.get('division')>
            <#assign department = local.get('department')>
            <#assign divisionUrl = "/access/searching.do?in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />
            <#assign departmentUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />

            <dd class="collection"><a href="${departmentUrl}">${department}</a> | <a href="${divisionUrl}">${division}</a></dd>
        </#list>

    <div id="images">
    <#list itemAttachments as itemAttachment>
        <#assign thumb = itemAttachment.get('thumbnail')>
        <#assign full = itemAttachment.get('file')>
        <a href="/file/${itemUuid}/${itemversion}/${full}">
        <img src="/file/${itemUuid}/${itemversion}/${thumb}"/></a>
    </#list>
    </div>

    <#assign objective = xml.getAllSubtrees('local/objective')>
    <#list local as local>
        <#assign objectivex = local.get('objective')>
        <#assign objectiveUrl = "" />
        <#if objectivex==""><#else>
        <dd>Event type:
            <#list objective as objective>
                <a href="${objectiveUrl}">${objective}</a><#if objective_has_next>; </#if>
            </#list>
        </#if>
    </#list>

    <#list modslevel as mods>
        <#assign abstract = mods.get('abstract')>
        <#if (abstract != "")>
             — ${abstract}
        </#if>
    </#list>
    </dd>

    <#list origininfo as origininfo>
        <#assign dateCreated = origininfo.get('dateCreatedWrapper/dateCreated')>
        <#assign semesterCreated = origininfo.get('semesterCreated')>
        <#assign semesterCreatedUrl = "" />
        <#if semesterCreated==""><#else>
            <dd>Date:
            <a href="${semesterCreatedUrl}">${semesterCreated}</a>
        </#if>
        <#if dateCreated==""><#else>; ${dateCreated}</#if>
            </dd>
    </#list>

    <#assign name = xml.getAllSubtrees('mods/subject/name')>
    <#list subject as subject>
        <#assign namex = subject.get('name')>
        <#if (namex != "")>
            <dd>Person(s) depicted:
            <#list name as name>
                <#assign nameUrl = "" />
                <#if name==""><#else>
                    <a href="${nameUrl}">${name}</a><#if name_has_next>, </#if>
                </#if>
            </#list>
            </dd>
        </#if>
    </#list>

</#if>

</#list>
