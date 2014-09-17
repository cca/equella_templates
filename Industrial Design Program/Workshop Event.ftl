<#assign itemUuid = xml.get('item/@id')>
<#assign itemversion = xml.get('item/@version')>
<#assign titleInfo = xml.getAllSubtrees('mods/titleInfo')>
<#assign itemAttachments = xml.getAllSubtrees('item/attachments/attachment')>
<#assign name = xml.getAllSubtrees('mods/name')>
<#assign subNameWrapper = xml.getAllSubtrees('mods/name/subNameWrapper')>
<#assign physdesc = xml.getAllSubtrees('mods/physicalDescription')>
<#assign modslevel = xml.getAllSubtrees('mods')>
<#assign subject = xml.getAllSubtrees('mods/subject')>
<#assign relateditem = xml.getAllSubtrees('mods/relateditem')>
<#assign courseWork = xml.getAllSubtrees('local/courseWorkWrapper')>
<#assign local = xml.getAllSubtrees('local')>
<#assign origininfo = xml.getAllSubtrees('mods/origininfo')>

<style scoped>
/* disable links that point nowhere */
a[href=""] {
  color: #4b4842; /* default text color */
  pointer-events: none;
}
</style>

<dl>
<#list courseWork as courseWork>
<#assign courseWorkType = courseWork.get('courseWorkType')>
<#if (courseWorkType =="Workshops / Events")>

    <#list titleInfo as titleInfo>
        <#assign title = titleInfo.get('title')>
        <#assign subTitle = titleInfo.get('subTitle')>
        <h2 id="title">${title}</h2>
</dl>
    </#list>

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
        <#assign thumb = itemAttachment.get('thumbnail')>
        <#assign full = itemAttachment.get('file')>
        <#if full?contains("http://") || full?ends_with(".zip")><#else>
            <a href="/file/${itemUuid}/${itemversion}/${full}">
            <img src="/file/${itemUuid}/${itemversion}/${thumb}"/></a>
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

    <#list modslevel as mods>
        <#assign abstract = mods.get('abstract')>
        <#if (abstract=="")><#else>
            <dd>Description: ${abstract}</dd></#if>
    </#list>

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


</#if>
</#list>
