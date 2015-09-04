<#assign title = xml.get('mods/titleInfo/title')>
<#if title != "">
    <h2>${title}</h2>
</#if>

<dt>Details</dt>

<#assign type = xml.get('mods/genreWrapper/genre')>
<#if type != "">
    <dd><b>Document Type</b>: ${xml.get('/mods/physicalDescription/formSpecific')}, ${type}</dd>
</#if>

<#assign year = xml.get('/mods/origininfo/dateCreatedWrapper/dateCreated')>
<#if year != "">
    <dd><b>Academic Year</b>: ${year}</dd>
</#if>

<#assign accreditors = xml.getAll('mods/subject/name')>
<#if (accreditors?size > 0)>
    <dd><b>Accreditor(s)</b>:
    <#list accreditors as accreditor>
        ${accreditor}<#if accreditor_has_next>, </#if>
    </#list>
    </dd>
</#if>

<#assign programs = xml.getAll('local/department')>
<#if (programs?size > 0)>
    <dd><b>Related Programs and Departments</b>:
    <#list programs as program>
        ${program}<#if program_has_next>, </#if>
    </#list>
    </dd>
</#if>

<#assign abstract = xml.get('mods/abstract')>
<#if abstract != "">
    <dt>Description</dt>
    <dd>${abstract}</dd>
</#if>
