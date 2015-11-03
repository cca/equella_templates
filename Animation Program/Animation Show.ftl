<#assign itemUuid = xml.get('item/@id')>
<#assign itemversion = xml.get('item/@version')>
<#assign titleInfo = xml.getAllSubtrees('mods/titleInfo')>
<#assign itemAttachments = xml.getAllSubtrees('item/attachments/attachment')>
<#assign name = xml.getAllSubtrees('mods/name')>
<#assign subNameWrapper = xml.getAllSubtrees('mods/name/subNameWrapper')>
<#assign physdesc = xml.getAllSubtrees('mods/physicalDescription')>
<#assign modslevel = xml.getAllSubtrees('mods')>
<#assign courseInfo = xml.getAllSubtrees('local/courseInfo')>
<#assign courseWork = xml.getAllSubtrees('local/courseWorkWrapper')>
<#assign local = xml.getAllSubtrees('local')>

<#list courseWork as courseWork>
<#assign courseWorkType = courseWork.get('courseWorkType')>
<#assign finalFile = courseWork.get('file')>
<#if courseWorkType == "Animation Show Submission">
<dl>
    <#list titleInfo as titleInfo>
        <#assign title = titleInfo.get('title')>
        <#assign subTitle = titleInfo.get('subTitle')>
        <h2 id="title">${title}</h2>
    </#list>

    <dt class="hide">Collection</dt>
    <#list local as local>
        <#assign division = local.get('division')>
        <#assign department = local.get('department')>
        <#assign divisionUrl = "/access/searching.do?doc=%3Cxml%2F%3E&in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&q=&sort=datemodified&dr=AFTER" />
        <#assign departmentUrl = "/access/searching.do?in=C66558697-71c5-43a0-b7b3-f778b42c7cd9&q=&sort=datemodified&dr=AFTER" />
        <dd class="collection"><a href="${departmentUrl}">${department}</a> | <a href="${divisionUrl}">${division}</a></dd>
    </#list>

    <dt>Description</dt>
    <#assign name = xml.getAllSubtrees('mods/name')>
    <#list name as name>
        <#assign namePart = name.get('namePart')>
        <dd>
            <#if namePart != "">
                <strong>Student:</strong> ${namePart}
            </#if>
            <#list name.getAllSubtrees('subNameWrapper') as subName>
                <#assign major = subName.get('major')>
                <#assign gradDate = subName.get('gradDate')>
                <#assign majorUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3Cname%3E%3CsubNameWrapper%3E%3Cmajor%3E${major}%3C%2Fmajor%3E%3C%2FsubNameWrapper%3E%3C%2Fname%3E%3C%2Flocal%3E%3Cmods%3E%3Cname%3E%3CsubNameWrapper%3E%3Cmajor%3E${major}%3C%2Fmajor%3E%3C%2FsubNameWrapper%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&q=&sort=datemodified&dr=AFTER" />
                <#assign gradDateUrl = "/access/searching.do?doc=%3Cxml%3E%3Cmods%3E%3Cname%3E%3CsubNameWrapper%3E%3CgradDate%3E${gradDate}%3C%2FgradDate%3E%3C%2FsubNameWrapper%3E%3C%2Fname%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&q=&sort=datemodified&dr=AFTER" />
                <#-- major does not seem to be included
                in any items of this type -->
                <#if major != ""> — <a href="${majorUrl}">${major}</a></#if>
                <#if gradDate != ""> — Graduated: <a href="${gradDateUrl}">${gradDate}</a></#if>
            </#list>
        </dd>
    </#list>

    <#list courseInfo as courseInfo>
        <#assign semester = courseInfo.get('semester')>
        <#assign semesterUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Csemester%3E${semester}%3C%2Fsemester%3E%3C%2FcourseInfo%3E%3Cdepartment%3EAnimation%3C%2Fdepartment%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&sort=datemodified&dr=AFTER" />
        <dd><strong>Semester of show:</strong> <a href="${semesterUrl}">${semester}</a></dd>
    </#list>

    <#assign workType = courseWork.get('workType')>
    <#assign imageType = courseWork.get('imageType')>
    <#-- note: PS is set to "Search full path" not just selected term
    e.g. "Production\Tradigital…" — which we don't usually do -->
    <#assign workTypeUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseWorkWrapper%3E%3CworkType%3E${workType}%3C%2FworkType%3E%3C%2FcourseWorkWrapper%3E%3Cdepartment%3EAnimation%3C%2Fdepartment%3E%3C%2Flocal%3E%3Cmods%3E%3C%2Fmods%3E%3C%2Fxml%3E&in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&q=&sort=datemodified&dr=AFTER" />
    <#assign imageTypeUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3Cdepartment%3EAnimation%3C%2Fdepartment%3E%3CcourseWorkWrapper%3E%3CimageType%3E${imageType}%3C%2FimageType%3E%3C%2FcourseWorkWrapper%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=Pc121f09c-8ea9-4bc9-90bf-8467c37a4ec4&q=&sort=datemodified&dr=AFTER" />

    <dd><strong>Reel description:</strong>
    <#if imageType == ""><em>no submission format selected</em><#else>
        <a href="${imageTypeUrl}">${imageType}</a>
    </#if>
    <#if workType == ""><em>no work type selected</em><#else>
         — <a href="${workTypeUrl}">${workType}</a>
    </#if>
</dl>
</#if>
</#list>
