<#assign itemUuid = xml.get('item/@id')>
<#assign itemversion = xml.get('item/@version')>
<#assign courseInfo = xml.getAllSubtrees('local/courseInfo')>
<#assign courseWork = xml.getAllSubtrees('local/courseWorkWrapper')>
<#-- need to change this one to VSCR -->
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

    <#list courseInfo as courseInfo>
        <#assign semester = courseInfo.get('semester')>
        <#assign course = courseInfo.get('course')>
        <#assign faculty = courseInfo.get('faculty')>
        <#assign section = courseInfo.get('section')>
        <#assign courseName = courseInfo.get('courseName')>
        <#assign courseUrl = "" />
        <#assign semesterUrl = "" />
        <#assign facultyUrl = "" />
        <#assign sectionUrl = "" />
        <#assign courseNameUrl = "" />
        <#if semester == ""><i>no course selected</i><#else>
            <dd><strong>Course:</strong>
            <a href="${semesterUrl}">${semester}</a>
                 — <a href="${courseUrl}">${course}</a>
                 — <a href="${facultyUrl}">${faculty}</a>
                 — <a href="${sectionUrl}">${section}</a>
             </dd>
        </#if>
    </#list>

    <dt>Senior Thesis Information</dt>

    <#list xml.getAllSubtrees('mods/name') as name>
        <#assign namePart = name.get('namePart')>
        <#if namePart != "">
            <dd><strong>Student:</strong> ${namePart}
        </#if>
        <#list name.getAllSubtrees('subNameWrapper') as subName>
            <#assign major = subName.get('major')>
            <#assign majorUrl = "/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3Cname%3E%3CsubNameWrapper%3E%3Cmajor%3E${major}%3C%2Fmajor%3E%3C%2FsubNameWrapper%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=${powerSearch}&q=&dr=AFTER" />
            <#if (major != "")>
                 — <a href="${majorUrl}">${major}</a>
            </#if>
        </#list>
        </dd>
    </#list>

    <#assign genres = xml.list('mods/genreWrapper/genre')>
    <#assign otherGenre = xml.get('mods/noteWrapper/note')>
    <#if (genres?size > 0)>
        <dd><strong>Genre(s):</strong>
        <#list genres as genre>
            <#if genre != "other...">
                ${genre}<#if genre_has_next>, </#if>
            <#else>
                ${otherGenre}<#if genre_has_next>, </#if>
            </#if>
        </#list>
        </dd>
    </#if>

    <#assign abstract = xml.get('mods/abstract')>
    <#if abstract != "">
        <dd><strong>Abstract:</strong><br>
            <pre>${abstract}</pre>
        </dd>
    </#if>
</dl>
</#if>
</#list>
