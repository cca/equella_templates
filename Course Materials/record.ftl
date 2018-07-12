<#function escapeAmp str>
    <#-- returns a URI-encoded "&amp;"
    because we pass XML in the URI, we have to escape this way -->
    <#return str?replace('&', '%26amp%3B')?replace('+', '%2B')>
</#function>
<#assign itemUuid = xml.get('item/@id')>
<#assign itemversion = xml.get('item/@version')>
<#assign attachments = xml.getAllSubtrees('item/attachments/attachment')>

<dl>
    <#assign title = xml.get('mods/titleInfo/title')>
    <h2 id="title">${title}</h2>

    <#list xml.getAllSubtrees('local/courseInfo') as courseInfo>
        <#assign semester = courseInfo.get('semester')>
        <#assign course = courseInfo.get('course')>
        <#assign faculty = courseInfo.get('faculty')>
        <#assign section = courseInfo.get('section')>
        <#assign courseUrl = "/access/searching.do?in=Ca2c779ec-2bda-4a4c-a68f-d63a149c6d7d&q=%22${course}%22">
        <#assign semesterUrl = "/access/searching.do?in=Ca2c779ec-2bda-4a4c-a68f-d63a149c6d7d&q=%22${semester}%22">
        <#assign facultyUrl = "/access/searching.do?in=Ca2c779ec-2bda-4a4c-a68f-d63a149c6d7d&q=%22${faculty}%22">
        <#assign sectionUrl = "/access/searching.do?in=Ca2c779ec-2bda-4a4c-a68f-d63a149c6d7d&q=%22${section}%22">
        <dt>Course Information</dt>
        <span id="coursestuff">
            <#if semester != "">
                <a href="${semesterUrl}">${semester}</a>
            </#if>
            <#if course != "">
                — <a href="${courseUrl}">${course}</a>
            </#if>
            <#if faculty != "">
                — <a href="${facultyUrl}">${faculty}</a>
            </#if>
            <#if section != "">
                — <a href="${sectionUrl}">${section}</a>
            </#if>
        </span>
    </#list>

    <dd><b>Type</b>: ${xml.get('/local/courseWorkWrapper/courseWorkType')}</dd>

    <#assign abstract = xml.get('mods/abstract')>
    <#if (abstract != "")>
        <dd><b>Description</b>: ${abstract}</dd>
    </#if>

    <#assign outcomes = xml.list('local/assignmentWrapper/ccaLOWrapper/ccaLO')>
    <#if (outcomes?size > 0)>
        <dd><b>CCA Learning Outcomes</b>:
        <#list outcomes as outcome>
            ${outcome}<#if outcome_has_next>, </#if>
        </#list></dd>
    </#if>

    <#assign tags = xml.list('local/tags')>
    <#if (tags?size > 0)>
        <dd><b>Special Programs/Tags</b>:
        <#list tags as tag>
            ${tag}<#if tag_has_next>, </#if>
        </#list></dd>
    </#if>
</dl>
