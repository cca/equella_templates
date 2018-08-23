<#assign name = xml.getAllSubtrees('mods/name')>
<#assign courseInfo = xml.getAllSubtrees('local/courseInfo')>
<#assign courseWork = xml.getAllSubtrees('local/courseWorkWrapper')>
<#assign local = xml.getAllSubtrees('local')>
<#assign search_url = 'https://vault.cca.edu/searching.do?in=C53426dda-dbd4-4a32-9155-4f6edaf64340&q='>

<dl>
<#assign title = xml.get('mods/titleInfo/title')>
<h2 id="title">${title}</h2>

<dt>Creator(s)</dt>
<#list name as name>
    <#assign namePart = name.get('namePart')>
    <dd>${namePart}
    <#list name.getAllSubtrees('subNameWrapper') as subName>
        <#assign major = subName.get('major')>
        <#assign majorUrl = "" />
        <#if (major != "")>
             — ${major}
        </#if>
    </#list>
</#list>

<#list local as local>
    <#assign academicLevel = local.get('academicLevel')>
    <#assign academicLevelUrl = "${search_url}%22${academicLevel?url}%22" />
        <#if (academicLevel != "")>
            — <a href="${academicLevelUrl}">${academicLevel}</a>
        </#if>
    </dd>
</#list>

<#list courseInfo as courseInfo>
    <#assign semester = courseInfo.get('semester')>
    <#assign course = courseInfo.get('course')>
    <#assign faculty = courseInfo.get('faculty')>
    <#assign section = courseInfo.get('section')>
    <#assign courseUrl = "${search_url}%22${course}%22">
    <#assign semesterUrl = "${search_url}%22${semester}%22">
    <#assign facultyUrl = "${search_url}%22${faculty}%22">
    <#assign sectionUrl = "${search_url}%22${section}%22">
    <#if (semester != "")>
        <dt>Course Info</dt>
        <span id="namestuff">
            <a href="${semesterUrl}">${semester}</a>
            — <a href="${courseUrl}">${course}</a>
            — <a href="${facultyUrl}">${faculty}</a>
            — <a href="${sectionUrl}">${section}</a>
        </span>
    </#if>
</#list>

<dt>Project Description</dt>
<#assign formBroad = xml.get('mods/physicalDescription/formBroad')>
<#if (formBroad != "")>
    <#assign formBroadUrl = "${search_url}%22${formBroad}%22">
    <dd>Work type: <a href="${formBroadUrl}">${formBroad}</a></dd>
</#if>

<#list courseWork as courseWork>
    <#assign materials = courseWork.list('material')>
    <#if (materials?size > 0)>
        <dd>Material(s):
            <#list materials as material>
                <#assign materialUrl = "${search_url}%22${material}%22">
                <a href="${materialUrl}">${material}</a><#if material_has_next>; </#if>
            </#list>
        </dd>
    </#if>

    <#assign materialsText = courseWork.get('materials_freetext')>
    <#if (materialsText != "")>
        <#assign materialsTextUrl = "${search_url}%22${materialsText}%22">
        <dd>Other materials: <a href="${materialsTextUrl}">${materialsText}</a></dd>
    </#if>

    <#assign groupProject = courseWork.get('groupProject')>
    <#if (groupProject != "")>
        <#assign groupProjectUrl = "${search_url}%22${groupProject}%22">
        <dd>Project type: <a href="${groupProjectUrl}">${groupProject}</a></dd>
    </#if>

    <#assign abstract = xml.get('mods/abstract')>
    <#if (abstract != "")>
        <dd>Description:<br><pre>${abstract}</pre></dd>
    </#if>
</#list>
