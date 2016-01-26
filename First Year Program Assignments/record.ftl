<#assign local = xml.getAllSubtrees('local')>
<#assign courseInfo = xml.getAllSubtrees('local/courseInfo')>
<#assign courseWork = xml.getAllSubtrees('local/courseWorkWrapper')>
<#assign assignmentWrapper = xml.getAllSubtrees('local/assignmentWrapper')>
<dl>
    <#assign title = xml.get('mods/titleInfo/title')>
    <h2 id="title">${title}</h2>

<#list courseInfo as courseInfo>
    <#assign semester = courseInfo.get('semester')>
    <#assign department = courseInfo.get('department')>
    <#assign course = courseInfo.get('course')>
    <#assign faculty = courseInfo.get('faculty')>
    <#assign section = courseInfo.get('section')>
    <#assign firstYearDimension = courseInfo.get('firstYearDimension')>
    <#assign courseUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Ccourse%3E${course}%3C%2Fcourse%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P6f96efa5-24ab-4bb8-ad27-169df9f9560d&q=&sort=datemodified&dr=AFTER" />
    <#assign semesterUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Csemester%3E${semester}%3C%2Fsemester%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P6f96efa5-24ab-4bb8-ad27-169df9f9560d&q=&sort=datemodified&dr=AFTER" />
    <#assign facultyUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Cfaculty%3E${faculty}%3C%2Ffaculty%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P6f96efa5-24ab-4bb8-ad27-169df9f9560d&q=&sort=datemodified&dr=AFTER" />
    <#assign sectionUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3Csection%3E${section}%3C%2Fsection%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P6f96efa5-24ab-4bb8-ad27-169df9f9560d&q=&sort=datemodified&dr=AFTER" />
    <#assign firstYearDimensionUrl = "/access/searching.do?doc=%3Cxml%3E%3Clocal%3E%3CcourseInfo%3E%3CfirstYearDimension%3E${firstYearDimension}%3C%2FfirstYearDimension%3E%3C%2FcourseInfo%3E%3C%2Flocal%3E%3C%2Fxml%3E&in=P6f96efa5-24ab-4bb8-ad27-169df9f9560d&q=&sort=name&dr=AFTER" />
    <#assign departmentUrl = "" />
    <#if (semester != "")>
    <dt>Course Information</dt>
    <span id="namestuff"><a href="${semesterUrl}">${semester}</a>
        <#if department != "undefined" && department != "">
             — <a href="${departmentUrl}">${department}</a>
        </#if>
        <#if firstYearDimension != "undefined" && firstYearDimension != "">
             — <a href="${firstYearDimensionUrl}">${firstYearDimension}</a>
        </#if>
        <#if course != "undefined" && course != "">
             — <a href="${courseUrl}">${course}</a>
        </#if>
        <#if faculty != "undefined" && faculty != "">
             — <a href="${facultyUrl}">${faculty}</a>
        </#if>
        <#if section != "undefined" && section != "">
             — <a href="${sectionUrl}">${section}</a>
        </#if>
    </span>
    </dd>
    </#if>
</#list>

<#list assignmentWrapper as assignmentWrapper>
    <dt>Assignment Information</dt>
    <#assign description = assignmentWrapper.get('description')>
    <#if description != "">
        <dd><strong>Description:</strong><br><pre>${description}</pre></dd>
    </#if>
    <#assign assignmentDue = assignmentWrapper.get('assignmentDue')>
    <#if assignmentDue != "" || assignmentDue != "other">
        <dd><strong>Assignment occurred during:</strong> ${assignmentDue}</dd>
    </#if>
    <#assign assignmentDueText = assignmentWrapper.get('assignmentDue_freetext')>
    <#if assignmentDueText != "">
        <dd><strong>Assignment occurred during:</strong> ${assignmentDueText}</dd>
    </#if>
    <#assign assignmentLength = assignmentWrapper.get('assignmentLength')>
    <#if assignmentLength != "" || assignmentLength != "other">
        <dd><strong>Assignment length:</strong> ${assignmentLength}</dd>
    </#if>
    <#assign assignmentLengthText = assignmentWrapper.get('assignmentLength_freetext')>
    <#if assignmentLengthText != "">
        <dd><strong>Assignment length:</strong> ${assignmentLengthText}</dd>
    </#if>
    <#assign references = assignmentWrapper.get('references')>
    <#if references != "">
        <dd><strong>Assignment references:</strong><br><pre>${references}</pre></dd>
    </#if>

    <#assign skills_freetext = xml.getAllSubtrees('local/skills_freetext')>
    <#list local as local>
        <#assign skills = local.list('skills')>
        <#assign skillsText = local.get('skills_freetext')>
        <#if skills?size != 0>
            <dd><strong>Skills used in work:</strong>
            <#list skills as skill>
                ${skill}<#if skill_has_next>; </#if>
            </#list>
            </dd>
        </#if>
        <#if skillsText != "">
            <dd><strong>Other skills:</strong> ${skillsText}</dd>
        </#if>

        <#assign thinkingProcesses = local.get('thinkingProcesses')>
        <#if thinkingProcesses != "">
            <dd><strong>Thinking Processes:</strong><br><pre>${thinkingProcesses}</pre></dd>
        </#if>

        <#assign critiqueStrategy = local.get('critiqueStrategy')>
        <#if critiqueStrategy != "">
            <dd><strong>Critique Strategy:</strong><br><pre>${critiqueStrategy}</pre></dd>
        </#if>

        <#if xml.get('/local/assignmentWrapper/programLOWrapper/programLO') != ''>
            <dd><strong>Program Learning Outcomes:</strong></dd>
            <ul class="standard">
            <#list assignmentWrapper.getAllSubtrees('programLOWrapper') as programLOWrapper>
                <#assign programLO = programLOWrapper.get('programLO')>
                <li>${programLO}</li>
            </#list>
            </ul>
        </#if>

        <#if xml.get('/local/assignmentWrapper/ccaLOWrapper/ccaLO') != ''>
            <dd><strong>CCA Learning Outcomes:</strong></dd>
            <ul class="standard">
            <#list assignmentWrapper.getAllSubtrees('ccaLOWrapper') as ccaLOWrapper>
                <#assign ccaLO = ccaLOWrapper.get('ccaLO')>
                <li>${ccaLO}</li>
            </#list>
            </ul>
        </#if>

        <#if xml.get('/local/assignmentWrapper/teachStrategyWrapper/teachStrategy') != ''>
            <dd><strong>Teaching Strategies:</strong></dd>
            <#list assignmentWrapper.getAllSubtrees('teachStrategyWrapper') as teachStrategyWrapper>
                <#assign teachStrategy = teachStrategyWrapper.get('teachStrategy')>
                <#assign teachStrategy_freetext = teachStrategyWrapper.get('teachStrategy_freetext')>
                <dd>${teachStrategy_freetext}</dd>
                <dd>${teachStrategy}</dd>
            </#list>
        </#if>

        <#assign ccaValues = local.list('ccaValues')>
        <#assign ccaValuesText = local.get('ccaValues_freetext')>
        <#if ccaValues?size != 0>
            <dd><strong>CCA Values:</strong>
            <#list ccaValues as ccaValue>
                ${ccaValue}<#if ccaValue_has_next>; </#if>
            </#list>
            </dd>
        </#if>
        <#if ccaValuesText != "">
            <dd><strong>Other CCA Values:</strong> ${ccaValuesText}</dd>
        </#if>
    </#list>

</#list>
</dl>
