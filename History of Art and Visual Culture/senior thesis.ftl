<#assign itemUuid = xml.get('item/@id')>
<#assign itemversion = xml.get('item/@version')>
<#assign courseInfo = xml.getAllSubtrees('local/courseInfo')>
<#assign courseWork = xml.getAllSubtrees('local/courseWorkWrapper')>
<#-- H&S division power search -->
<#assign powerSearch = 'Pe78fd93a-86cd-40a9-9382-e86897646a2d'>

<#list courseWork as courseWork>
<#assign courseWorkType = courseWork.get('courseWorkType')>
<#if courseWorkType == 'Senior packet'>
<dl>
    <#assign title = xml.get('mods/titleInfo/title')>
    <h2 id="title">${title}</h2>

    <dt class="hide">Collection</dt>
    <#assign division = xml.get('local/division')>
    <#assign department = xml.get('local/department')>
    <#assign divisionUrl = "/access/searching.do?in=${powerSearch}&q=&dr=AFTER" />
    <#assign departmentUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3Cdepartment%3E${department}%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER"/>
    <dd class="collection">
        <a href="${departmentUrl}">${department}</a> | <a href="${divisionUrl}">${division}</a>
    </dd>
    <br />

    <dd><strong>Program Chair:</strong> ${xml.get('local/thesisWrapper/reader')}</dd>
    <dd><strong>Internal Advisor:</strong> ${xml.get('local/thesisWrapper/advisor')}</dd>
    <#-- nowhere left to put this metadata… -->
    <dd><strong>Thesis Director:</strong> ${xml.get('mods/noteWrapper/note')}</dd>

    <dt>Senior Thesis Information</dt>

    <#list xml.getAllSubtrees('mods/name') as name>
        <#assign namePart = name.get('namePart')>
        <#if namePart != "">
            <dd><strong>Student:</strong> ${namePart}
        </#if>
        <#list name.list('subNameWrapper/major') as major>
            <#assign majorUrl = "">
                 — <a href="${majorUrl}">${major}</a>
        </#list>
        <#list name.list('subNameWrapper/minor') as minor> - ${minor} Minor</#list>
        </dd>
    </#list>

    <#assign abstract = xml.get('mods/abstract')>
    <#if abstract != "">
        <dd><strong>Abstract:</strong><br>
            <pre>${abstract}</pre>
        </dd>
    </#if>

    <#assign keywords = xml.list('local/tags')>
    <#if keywords?size != 0>
        <dd><strong>Keyword(s):</strong>
        <#list keywords as keyword>
                ${keyword}<#if keyword_has_next>, </#if>
        </#list>
        </dd>
    </#if>
</dl>
</#if>
</#list>
