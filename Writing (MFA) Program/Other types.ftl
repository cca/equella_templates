<#--
for 2 simple, additional types of content submitted by faculty
- Thesis Candidacy Review: Narrative Evaluation
- Second Semester Advancement Review
-->
<#assign itemUuid = xml.get('item/@id')>
<#assign itemversion = xml.get('item/@version')>
<#assign itemAttachments = xml.getAllSubtrees('item/attachments/attachment')>
<#assign courseWorkType = xml.get('local/courseWorkWrapper/courseWorkType')>

<#if courseWorkType == 'Thesis Candidacy Narrative' || courseWorkType == '2nd Semester Advancement Review'>

<dl>
    <#assign title = xml.get('mods/titleInfo/title')>
    <h2 id="title">${title}</h2>

    <dt>Student &amp; Faculty</dt>
    <dd><b>Student</b>: ${xml.get('mods/name/namePart')}</dd>
    <dd><b>Faculty</b>: ${xml.get('local/courseInfo/faculty')}</dd>
    <dd><b>Semester</b>: ${xml.get('local/courseInfo/semester')}</dd>

    <dt>Details</dt>

    <dd>
        <b>Type</b>:
        <#if courseWorkType == 'Thesis Candidacy Narrative'>
            Thesis Candidacy Review: Narrative Evaluation
        <#elseif courseWorkType == '2nd Semester Advancement Review'>
            Second Semester Advancement Review
        <#else>
            <#-- theroetically impossible as courseWorkType is required -->
            <em class="text-error">no type selected</em>
        </#if>
    </dd>

    <#assign genres = xml.list('/mods/genreWrapper/genre')>
    <#if genres?size != 0>
        <dd><b>Genre(s)</b>: <#list genres as genre>
            ${genre}<#if genre_has_next>, </#if>
        </#list></dd>
    </#if>

    <#assign rating = xml.get('local/rating')>
    <#if rating != "">
        <dd><b>Progress (1-10 rating)</b>: ${rating}</dd>
    </#if>

    <#assign recommendations = xml.get('/local/projectWrapper/description')>
    <#if recommendations != ''>
        <dd>
            <b>Recommendations</b>:<br>
            <pre>${recommendations}</pre>
        </dd>
    </#if>

    <#assign abstract = xml.get('mods/abstract')>
    <#if abstract != ''>
        <dd>
            <b>Comments</b>:<br>
            <pre>${abstract}</pre>
        </dd>
    </#if>

    <#assign evaluation = xml.get('mods/part/number')>
    <#if evaluation != ''>
        <dd id="images">
            <#list itemAttachments as itemAttachment>
                <#assign uuid = itemAttachment.get('uuid')>
                <#assign full = itemAttachment.get('file')>
                <a href="/file/${itemUuid}/${itemversion}/${full}">
                <img src="/thumbs/${itemUuid}/${itemversion}/${uuid}"/></a>
            </#list>
        </dd>
    </#if>

</dl>
</#if>
