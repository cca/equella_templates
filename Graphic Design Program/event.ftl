<#assign itemUuid = xml.get('item/@id')>
<#assign itemversion = xml.get('item/@version')>
<#assign itemAttachments = xml.getAllSubtrees('item/attachments/attachment')>
<#assign subject = xml.getAllSubtrees('mods/subject')>
<#assign courseWork = xml.getAllSubtrees('local/courseWorkWrapper')>
<#assign local = xml.getAllSubtrees('local')>
<#assign origininfo = xml.getAllSubtrees('mods/origininfo')>

<#list courseWork as courseWork>
    <#assign courseWorkType = courseWork.get('courseWorkType')>
    <#if courseWorkType == "Workshop / Events">

    <dl>
        <#assign title = xml.get('mods/titleInfo/title')>
        <h2 id="title">${title}</h2>

        <dt class="hide">Collection</dt>
            <#list local as local>
                <#assign division = local.get('division')>
                <#assign department = local.get('department')>
                <#assign divisionUrl = "/access/searching.do?in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />
                <#assign departmentUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P3ee81fed-6f99-4179-a7b9-d7e96ca6d4c3&q=&sort=datemodified&dr=AFTER" />

                <dd class="collection"><a href="${departmentUrl}">${department}</a> | <a href="${divisionUrl}">${division}</a></dd>
            </#list>

        <#assign objective = xml.getAllSubtrees('local/objective')>
        <#list local as local>
            <#assign objectivex = local.get('objective')>
            <#-- TODO fix this URL -->
            <#assign objectiveUrl = "" />
            <#if objectivex != "">
            <dd>Event type:
                <#list objective as objective>
                    <a href="${objectiveUrl}">${objective}</a><#if objective_has_next>; </#if>
                </#list>
            </#if>
        </#list>

        <#assign abstract = xml.get('mods/abstract')>
        <#if (abstract != "")>
             — ${abstract}
        </#if>
        </dd>

        <#list origininfo as origininfo>
            <#assign dateCreated = origininfo.get('dateCreatedWrapper/dateCreated')>
            <#assign semesterCreated = origininfo.get('semesterCreated')>
            <#assign semesterCreatedUrl = "" />
            <#if semesterCreated != "">
                <dd>Date:
                <a href="${semesterCreatedUrl}">${semesterCreated}</a>
            </#if>
            <#if dateCreated != "">; ${dateCreated}</#if>
                </dd>
        </#list>

        <#list subject as subject>
            <#assign names = subject.list('name')>
            <#if (names?size > 0)>
                <dd>Person(s) depicted:
                <#list names as name>
                    <#-- TODO fix URL -->
                    <#assign nameUrl = "">
                    <#if name != "">
                        <a href="${nameUrl}">${name}</a><#if name_has_next>, </#if>
                    </#if>
                </#list>
                </dd>
            </#if>
        </#list>

        <div id="images">
        <#list itemAttachments as itemAttachment>
            <#assign uuid = itemAttachment.get('uuid')>
            <#assign full = itemAttachment.get('file')>
            <#if full?ends_with(".pdf")>
                <a href="/file/${itemUuid}/${itemversion}/${full}" class="pdf">
                <img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
            <#elseif ! full?contains("http://") && ! full?ends_with(".zip")>
                <a href="/file/${itemUuid}/${itemversion}/${full}" rel="group" class="img">
                <img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
            </#if>
        </#list>
        </div>
    </#if>
</#list>
