<#if xml.get('local/courseWorkWrapper/courseWorkType') == 'Course work'>
<dl>

<#-- @todo what PS does Diversity Studies go in? -->
<#assign powerSearch = ''>

<#assign title = xml.get('mods/titleInfo/title')>
<h2 id="title">${title}</h2>
<#assign division = xml.get('local/division')>
<#assign department = xml.get('local/department')>
<#assign departmentUrl = "/access/searching.do?in=Ce628c67e-886e-414b-af7f-cb0e6adaae07&q=&sort=datemodified&dr=AFTER" />
<dd class="collection">
    <#-- Interdisciplinary Studies PS is yet to be made -->
    ${division} |
    <a href="${departmentUrl}">${department}</a>
</dd>

<dt>Creator(s)</dt>
<#list xml.getAllSubtrees('mods/name') as name>
    <#assign namePart = name.get('namePart')>
    <dd>${namePart}
    <#list name.getAllSubtrees('subNameWrapper') as subName>
        <#assign major = subName.get('major')>
        <#assign majorUrl = "">
        <#if (major != "")>
             — <a href="${majorUrl}">${major}</a>
        </#if>
    </#list>
</#list>

<#assign academicLevel = xml.get('local/academicLevel')>
<#assign academicLevelUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CacademicLevel%3E${academicLevel}%3C%2FacademicLevel%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=&sort=datemodified&dr=AFTER" />
    <#if (academicLevel != "")>
        — <a href="${academicLevelUrl}">${academicLevel}</a>
    </#if>
</dd>

<#list xml.getAllSubtrees('local/courseInfo') as courseInfo>
    <#assign semester = courseInfo.get('semester')>
    <#assign department = courseInfo.get('department')>
    <#assign course = courseInfo.get('course')>
    <#assign faculty = courseInfo.get('faculty')>
    <#assign section = courseInfo.get('section')>
    <#assign courseUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Ccourse%3E${course}%3C%2Fcourse%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=&sort=datemodified&dr=AFTER" />
    <#assign semesterUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Csemester%3E${semester}%3C%2Fsemester%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=&sort=datemodified&dr=AFTER" />
    <#assign facultyUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Cfaculty%3E${faculty}%3C%2Ffaculty%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=&sort=datemodified&dr=AFTER" />
    <#assign sectionUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Csection%3E${section}%3C%2Fsection%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=${powerSearch}&q=&sort=datemodified&dr=AFTER" />
    <#assign departmentUrl = "" />
    <#if (semester != "")>
        <dt>Course Info</dt>
        <span id="namestuff">
            ${semester}
            — ${course}
            — ${faculty}
            — ${section}
        </span>
    </#if>

</#list>

<dt>Project Description</dt>
<#assign formBroad = xml.get('mods/physicalDescription/formBroad')>
<#if (formBroad != "")>
    <dd>Work type: ${formBroad}</dd>
</#if>

<#list xml.getAllSubtrees('local/courseWorkWrapper') as courseWork>
    <#assign materials = courseWork.list('material')>
    <#if (materials?size != 0)>
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

    <#assign groupMembers = courseWork.get('groupMembers')>
    <#if (groupMembers != "")>
        <dd>Group members: ${groupMembers}</dd>
    </#if>

    <#assign abstract = xml.get('mods/abstract')>
    <#if (abstract != "")>
        <dd>Description:<br><pre>${abstract}</pre></dd>
    </#if>
</#list>

</#if>
