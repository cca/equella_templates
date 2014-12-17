<#list xml.getAllSubtrees('local/courseWorkWrapper') as courseWork>
<#assign courseWorkType = courseWork.get('courseWorkType')>
<#if (courseWorkType == "CORE Studio/First Year" || courseWorkType == "Studio elective")>
<#assign courseInfo = xml.getAllSubtrees('local/courseInfo')>
<dl>
    <#assign title = xml.get('mods/titleInfo/title')>
    <h2 id="title">${title}</h2>

    <dt>Creator(s)</dt>
    <#list xml.getAllSubtrees('mods/name') as name>
        <#assign namePart = name.get('namePart')>
        <dd>${namePart}
        <#list name.getAllSubtrees('subNameWrapper') as subName>
            <#assign major = subName.get('major')>
            <#if (major != "")>
                 — ${major}
            </#if>
        </#list>
    </#list>

    <#assign academicLevel = xml.get('local/academicLevel')>
    <#assign academicLevelUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CacademicLevel%3E${academicLevel}%3C%2FacademicLevel%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P6f96efa5-24ab-4bb8-ad27-169df9f9560d&q=&sort=datemodified&dr=AFTER" />
        <#if (academicLevel != "")>
             — <a href="${academicLevelUrl}">${academicLevel}</a>
        </#if>
    </dd>

    <#list courseInfo as courseInfo>
        <#assign semester = courseInfo.get('semester')>
        <#assign department = courseInfo.get('department')>
        <#assign course = courseInfo.get('course')>
        <#assign faculty = courseInfo.get('faculty')>
        <#assign section = courseInfo.get('section')>
        <#assign firstYearDimension = courseInfo.get('firstYearDimension')>
        <#assign separateCourse = courseInfo.get('secondXList')>
        <#assign studioCourse = courseInfo.get('XList')>
        <#assign courseUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Ccourse%3E${course}%3C%2Fcourse%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P6f96efa5-24ab-4bb8-ad27-169df9f9560d&q=&sort=datemodified&dr=AFTER" />
        <#assign semesterUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Csemester%3E${semester}%3C%2Fsemester%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P6f96efa5-24ab-4bb8-ad27-169df9f9560d&q=&sort=datemodified&dr=AFTER" />
        <#assign facultyUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Cfaculty%3E${faculty}%3C%2Ffaculty%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P6f96efa5-24ab-4bb8-ad27-169df9f9560d&q=&sort=datemodified&dr=AFTER" />
        <#assign sectionUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Csection%3E${section}%3C%2Fsection%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P6f96efa5-24ab-4bb8-ad27-169df9f9560d&q=&sort=datemodified&dr=AFTER" />
        <#assign firstYearDimensionUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3CfirstYearDimension%3E${firstYearDimension}%3C%2FfirstYearDimension%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P6f96efa5-24ab-4bb8-ad27-169df9f9560d&q=&sort=datemodified&dr=AFTER" />
        <#assign departmentUrl = "" />
        <#assign separateCourseUrl = "" />
        <#assign studioCourseUrl = "" />
        <#if (semester != "")>
        <dt>Course Info</dt>
        <span id="namestuff"><a href="${semesterUrl}">${semester}</a>
            <#if (firstYearDimension == "undefined") || (firstYearDimension == "")>
                <#else> — <a href="${firstYearDimensionUrl}">${firstYearDimension}</a>
            </#if>
            <#if (semester == "Fall 2013")>
                <#if (separateCourse == "undefined") || (separateCourse == "")>
                    <#else> — <a href="${separateCourseUrl}">${separateCourse}</a>
                </#if>
                <#if (studioCourse == "undefined") || (studioCourse == "")>
                    <#else> — <a href="${studioCourseUrl}">${studioCourse}</a>
                </#if>
            <#elseif (semester!="Fall 2013")>
                <#if (course == "undefined") || (course == "")>
                    <#else> — <a href="${courseUrl}">${course}</a>
                </#if>
            </#if>

                <#if (faculty == "undefined") || (faculty == "")>
                    <#else> — <a href="${facultyUrl}">${faculty}</a>
                </#if>

                <#if (section == "undefined") || (section == "")>
                    <#else> — <a href="${sectionUrl}">${section}</a>
                </#if> <!-- test comment -->

        </span>
        </#if>
    </#list>

    <#assign formBroad = xml.get('mods/physicalDescription/formBroad')>
    <#if (formBroad != "")>
        <dt>Project Description</dt>
        <dd>Work type: ${formBroad}</dd>
    </#if>

    <#assign materials = courseWork.list('material')>
    <#assign materialsText = courseWork.get('materials_freetext')>
    <#assign groupProject = courseWork.get('groupProject')>
    <#if (materials?size != 0)>
        <dd>Material(s):
            <#list materials as material>
                ${material}<#if material_has_next>; </#if>
            </#list>
        </dd>
    </#if>
    <#if (materialsText != "")>
        <dd>Other materials: ${materialsText}</dd>
    </#if>
    <#if (groupProject != "")>
        <dd>Project type: ${groupProject}</dd>
    </#if>

    <#assign abstract = xml.get('mods/abstract')>
    <#if (abstract != "")>
        <dd>Description: ${abstract}</dd>
    </#if>

</#if>
</#list>
