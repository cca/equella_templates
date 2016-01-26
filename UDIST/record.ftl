<#assign name = xml.getAllSubtrees('mods/name')>
<#assign courseInfo = xml.getAllSubtrees('local/courseInfo')>
<#assign courseWork = xml.getAllSubtrees('local/courseWorkWrapper')>
<#assign local = xml.getAllSubtrees('local')>

<dl>
<#assign title = xml.get('mods/titleInfo/title')>
<h2 id="title">${title}</h2>

<dt>Creator(s)</dt>
<#list name as name>
    <#assign namePart = name.get('namePart')>
    <dd>${namePart}
    <#list name.getAllSubtrees('subNameWrapper') as subName>
        <#assign major = subName.get('major')>
        <#-- @todo fill in URL -->
        <#assign majorUrl = "" />
        <#if (major != "")>
             — ${major}
        </#if>
    </#list>
</#list>

<#list local as local>
    <#assign academicLevel = local.get('academicLevel')>
    <#assign academicLevelUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CacademicLevel%3E${academicLevel}%3C%2FacademicLevel%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P6f96efa5-24ab-4bb8-ad27-169df9f9560d&q=&sort=datemodified&dr=AFTER" />
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
    <#-- @todo what Power Search is this? -->
    <#assign courseUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Ccourse%3E${course}%3C%2Fcourse%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P6f96efa5-24ab-4bb8-ad27-169df9f9560d&q=&sort=datemodified&dr=AFTER" />
    <#assign semesterUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Csemester%3E${semester}%3C%2Fsemester%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P6f96efa5-24ab-4bb8-ad27-169df9f9560d&q=&sort=datemodified&dr=AFTER" />
    <#assign facultyUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Cfaculty%3E${faculty}%3C%2Ffaculty%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P6f96efa5-24ab-4bb8-ad27-169df9f9560d&q=&sort=datemodified&dr=AFTER" />
    <#assign sectionUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Csection%3E${section}%3C%2Fsection%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P6f96efa5-24ab-4bb8-ad27-169df9f9560d&q=&sort=datemodified&dr=AFTER" />
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
    <dd>Work type: ${formBroad}</dd>
</#if>

<#list courseWork as courseWork>
    <#assign materials = courseWork.list('material')>
    <#if (materials?size > 0)>
        <dd>Material(s):
            <#list materials as material>
                ${material}<#if material_has_next>; </#if>
            </#list>
        </dd>
    </#if>

    <#assign materialsText = courseWork.get('materials_freetext')>
    <#if (materialsText != "")>
        <dd>Other materials: ${materialsText}</dd>
    </#if>

    <#assign groupProject = courseWork.get('groupProject')>
    <#if (groupProject != "")>
        <dd>Project type: ${groupProject}</dd>
    </#if>

    <#assign abstract = xml.get('mods/abstract')>
    <#if (abstract != "")>
        <dd>Description:<br><pre>${abstract}</pre></dd>
    </#if>
</#list>
